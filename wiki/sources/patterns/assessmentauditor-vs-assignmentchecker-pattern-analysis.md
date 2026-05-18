---
description: "AssessmentAuditor vs AssignmentChecker: Lambda Service Pattern Analysis"
tags: ['research']
raw_file: "AssessmentAuditor vs AssignmentChecker Pattern Analysis.md"
created: 2026-05-17
---

# AssessmentAuditor vs AssignmentChecker: Lambda Service Pattern Analysis

> **Summary:** Both services implement the identical "Lambda Service Pattern" -- a three-tier architecture of `Function` (entry point) -> `Engine` (business orchestration) -> `DataService` (GraphQL client wrapper), wired together via identical DI configuration shapes in `Startup.cs`. The only meaningful differences are business-domain specific: event payloads, external service integrations (Learnosity/Kinesis vs none), and the particular GraphQL services consumed. The structural scaffolding is copy-paste identical, strongly suggesting these should be merged into a shared generic Lambda framework.

---

## 1. AssessmentAuditor

### 1.1 Function.cs -- Entry Point

```csharp
using Amazon.Lambda.Annotations;
using Amazon.Lambda.Core;
using Microsoft.Extensions.Logging;
using NewClassrooms.AssessmentAuditor.Business;
using NewClassrooms.Shared.Logging;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace NewClassrooms.AssessmentAuditor;

public class Function
{
    private readonly ILogger<Function> _logger;
    private readonly Engine _engine;

    public Function(ILogger<Function> logger, Engine engine)
    {
        _logger = logger;
        _engine = engine;
    }

    [LambdaFunction]
    public async Task Handle(ILambdaContext context)
    {
        _logger.LogInformation($"Function called with {context.AwsRequestId}");

        try
        {
            await _engine.RunAsync();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex.Message, ex);
        }
    }
}
```

**Pattern notes:**
- `LambdaSerializer` assembly attribute for JSON deserialization.
- `[LambdaFunction]` attribute marks the handler.
- Constructor injects `ILogger<Function>` and `Engine`.
- `Handle` takes only `ILambdaContext` (no custom payload -- this is a scheduled/timer-triggered Lambda).
- Minimal try/catch wrapper; all work delegated to `_engine.RunAsync()`.
- XML doc explicitly states: "Don't write tests that call this method."

---

### 1.2 Startup.cs -- DI Configuration

```csharp
using Amazon.CloudWatch;
using Amazon.Kinesis;
using Amazon.Lambda.Annotations;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using NewClassrooms.AssessmentAuditor.Business;
using NewClassrooms.AssessmentAuditor.Business.CloudWatch;
using NewClassrooms.AssessmentAuditor.Business.Kinesis;
using NewClassrooms.AssessmentAuditor.Business.NcData;
using NewClassrooms.GraphQLClient.Authentication;
using NewClassrooms.GraphQLClient.IServices;
using NewClassrooms.GraphQLClient.Services;
using NewClassrooms.Shared.Authentication;
using NewClassrooms.Shared.Environment;
using NewClassrooms.Shared.Events;
using NewClassrooms.Shared.Events.Payloads;
using NewClassrooms.Shared.Learnosity;
using NewClassrooms.Shared.Learnosity.Api;

namespace NewClassrooms.AssessmentAuditor
{
    [LambdaStartup]
    public class Startup : Shared.Environment.Startup
    {
        public Startup() : base(new HashSet<string>
        {
            nameof(LambdaEnvironment.GraphQlServerUrl),
            nameof(LambdaEnvironment.KinesisEventStreamArn)
        })
        {
        }

        public override void ConfigureServices(IServiceCollection services)
        {
            base.ConfigureServices(services);
            services
                .Configure<LearnosityApiConfiguration>(options => Application.Configuration.GetSection("LEARNOSITY").Bind(options, configOptions => configOptions.BindNonPublicProperties = true))
                .AddSingleton<LearnosityApiConfiguration>()
                .AddSingleton<AwsSecretProvider>()
                .AddSingleton(Environment)
                .AddScoped<LearnosityApiClient>()
                .AddScoped<ILearnosityService>(provider =>
                {
                    var loggerFactory = provider.GetRequiredService<ILoggerFactory>();
                    var config = provider.GetRequiredService<IOptions<LearnosityApiConfiguration>>();
                    var awsSecretProvider = provider.GetRequiredService<AwsSecretProvider>();
                    var learnosityApiClient = provider.GetRequiredService<LearnosityApiClient>();
                    return new LearnosityService(loggerFactory, config, awsSecretProvider, learnosityApiClient);
                })
                .AddScoped<IAmazonKinesis, AmazonKinesisClient>()
                .AddScoped<IAmazonCloudWatch, AmazonCloudWatchClient>()
                .AddScoped<ICloudWatchMetricPublisher, CloudWatchMetricPublisher>()
                .AddScoped<IGraphQLResponseUnwrapper, GraphQLResponseUnwrapper>()
                .AddScoped<IStudentSkillAssessmentService, StudentSkillAssessmentService>()
                .AddScoped<IStudentSkillDiagnosticService, StudentSkillDiagnosticService>()
                .AddScoped<IEventSender<LearnosityResultPayload>>(
                provider => new EventSender<LearnosityResultPayload>(
                    Environment.KinesisEventStreamArn,
                    provider.GetRequiredService<IAmazonKinesis>(),
                    Shared.Enums.EventType.DiagnosticCompleted
                    )
                )
                .AddScoped<IEventSender<LearnosityResultPayload>>(
                provider => new EventSender<LearnosityResultPayload>(
                    Environment.KinesisEventStreamArn,
                    provider.GetRequiredService<IAmazonKinesis>(),
                    Shared.Enums.EventType.SkillAssessmentSubmitted
                    )
                )
                .AddScoped<IKinesisEventSender, KinesisEventSender>()
                .AddScoped<IDataService, DataService>()
                .AddScoped<Engine>()
                .AddHttpContextAccessor()
                .AddGraphQLClientWithAuth(client => client.BaseAddress = new Uri(Environment.GraphQlServerUrl), Application);
        }
    }
}
```

**Pattern notes:**
- `[LambdaStartup]` on a class inheriting `Shared.Environment.Startup`.
- Constructor validates required environment variables via `HashSet<string>`.
- Fluent `IServiceCollection` chain registering:
  - Singletons: config objects, `AwsSecretProvider`, `Environment`.
  - Scoped GraphQL services: `IGraphQLResponseUnwrapper`, domain-specific service interfaces.
  - Scoped AWS SDK clients: `IAmazonKinesis`, `IAmazonCloudWatch`.
  - Scoped business services: `IDataService`, `Engine`.
  - `AddGraphQLClientWithAuth` extension for GraphQL client setup.

---

### 1.3 Engine.cs -- Business Logic Delegation

```csharp
using Microsoft.Extensions.Logging;
using NewClassrooms.AssessmentAuditor.Business.CloudWatch;
using NewClassrooms.AssessmentAuditor.Business.Kinesis;
using NewClassrooms.AssessmentAuditor.Business.NcData;
using NewClassrooms.Shared.Learnosity;
using NewClassrooms.Shared.Logging;

namespace NewClassrooms.AssessmentAuditor.Business;

public class Engine
{
    private readonly ILoggerFactory _loggerFactory;
    private readonly ILogger<Engine> _logger;
    private readonly ILearnosityService _learnosityService;
    private readonly ICloudWatchMetricPublisher _cloudWatchMetricPublisher;
    private readonly IKinesisEventSender _kinesisEventSender;
    private readonly IDataService _dataService;
    private const string DIAGNOSTIC_ACTIVITY_ID = "Diagnostic_";
    private const string ASSESSMENT_ACTIVITY_ID = "JUMPSTART_PROVE_IT_";
    private const string METRIC_MISSING_DIAGNOSTICS_COUNT = "MissingDiagnosticsCount";
    private const string METRIC_MISSING_ASSESSMENTS_COUNT = "MissingAssessmentsCount";
    private const string ENV_CURRENT_TIME_OFFSET = "CURRENT__TIME__OFFSET";
    private const string ENV_DURATION_OFFSET = "DURATION__OFFSET";
    private readonly int currentTimeOffset = int.TryParse(Environment.GetEnvironmentVariable(ENV_CURRENT_TIME_OFFSET), out int result) ? result : 10;
    private readonly int durationOffset = int.TryParse(Environment.GetEnvironmentVariable(ENV_DURATION_OFFSET), out int result) ? result : 30;
    private readonly DateTime currentTime;
    private readonly DateTime lastRunTime;

    public Engine(
        ILoggerFactory loggerFactory,
        ILearnosityService learnosityService,
        ICloudWatchMetricPublisher cloudWatchMetricPublisher,
        IKinesisEventSender kinesisEventSender,
        IDataService dataService
        )
    {
        _loggerFactory = loggerFactory;
        _logger = _loggerFactory.CreateLogger<Engine>();
        _learnosityService = learnosityService;
        _cloudWatchMetricPublisher = cloudWatchMetricPublisher;
        _kinesisEventSender = kinesisEventSender;
        _dataService = dataService;
        currentTime = DateTime.UtcNow.AddMinutes(-currentTimeOffset);
        lastRunTime = currentTime.AddMinutes(-durationOffset);
    }

    public async Task RunAsync()
    {
        var learnosityDiagnostics = await _learnosityService.GetCompletedDiagnosticsInGivenTimeRangeAsync(lastRunTime, currentTime);
        var learnosityDiagnosticsIds = learnosityDiagnostics?.Where(x => x.ActivityId.StartsWith(DIAGNOSTIC_ACTIVITY_ID)).Select(x => x.SessionId).ToHashSet() ?? new HashSet<Guid>();
        _logger.LogInformation($"Learnosity diagnostics ids from {lastRunTime} to {currentTime} are: [{string.Join(",", learnosityDiagnosticsIds)}].");

        if (learnosityDiagnosticsIds.Count != 0)
        {
            var ncDiagnosticsIds = await _dataService.GetNcDiagnosticsAsync(lastRunTime, currentTime);
            var missingDiagnosticIds = learnosityDiagnosticsIds.Except(ncDiagnosticsIds);
            _logger.LogInformation($"Missing diagnostic session Ids from {lastRunTime} to {currentTime} are: [{string.Join(",", missingDiagnosticIds)}].");
            if (missingDiagnosticIds.Any())
            {
                await _kinesisEventSender.PublishKinesisMissingEventsAsync(missingDiagnosticIds, Shared.Enums.EventType.DiagnosticCompleted);
                await _cloudWatchMetricPublisher.PublishMissingSessionIdsAsync(missingDiagnosticIds.Count(), METRIC_MISSING_DIAGNOSTICS_COUNT);
            }
        }

        var learnosityAssessments = await _learnosityService.GetCompletedAssessmentsInGivenTimeRangeAsync(lastRunTime, currentTime);
        var learnosityAssessmentsIds = learnosityAssessments?.Where(x => x.ActivityId.StartsWith(ASSESSMENT_ACTIVITY_ID)).Select(x => x.SessionId).ToHashSet() ?? new HashSet<Guid>();
        _logger.LogInformation($"Learnosity assessments from {lastRunTime} to {currentTime} are: [{string.Join(",", learnosityAssessmentsIds)}].");

        if (learnosityAssessmentsIds.Count != 0)
        {
            var ncAssessmentIds = await _dataService.GetNcAssessmentsAsync(lastRunTime, currentTime);
            var missingAssessmentIds = learnosityAssessmentsIds.Except(ncAssessmentIds);
            _logger.LogInformation($"Missing assessment ids from {lastRunTime} to {currentTime} are: [{string.Join(",", missingAssessmentIds)}].");
            if (missingAssessmentIds.Any())
            {
                await _kinesisEventSender.PublishKinesisMissingEventsAsync(missingAssessmentIds, Shared.Enums.EventType.SkillAssessmentSubmitted);
                await _cloudWatchMetricPublisher.PublishMissingSessionIdsAsync(missingAssessmentIds.Count(), METRIC_MISSING_ASSESSMENTS_COUNT);
            }
        }
    }
}
```

**Pattern notes:**
- Constructor receives `ILoggerFactory` (creates its own logger) plus domain service dependencies.
- Business constants and environment-variable-driven configuration defined as fields.
- `RunAsync()` with no parameters (timer-triggered).
- Orchestrates calls to external services (`ILearnosityService`), data layer (`IDataService`), and event publishers (`IKinesisEventSender`).
- XML doc: "Don't use this method in your tests" -- same anti-pattern note as Function.

---

### 1.4 DataService.cs -- GraphQL Client Wrapper

```csharp
using Microsoft.Extensions.Logging;
using NewClassrooms.GraphQLClient.IServices;
using NewClassrooms.Shared.Filters;

namespace NewClassrooms.AssessmentAuditor.Business.NcData;

public class DataService : IDataService
{
    private readonly ILogger<DataService> _logger;
    private readonly IStudentSkillDiagnosticService _studentSkillDiagnosticService;
    private readonly IStudentSkillAssessmentService _studentSkillAssessmentService;
    private readonly IGraphQLResponseUnwrapper _graphQLResponseUnwrapper;

    public DataService(IStudentSkillDiagnosticService studentSkillDiagnosticService,
        IStudentSkillAssessmentService studentSkillAssessmentService, ILogger<DataService> logger, IGraphQLResponseUnwrapper graphQLResponseUnwrapper)
    {
        _logger = logger;
        _studentSkillDiagnosticService = studentSkillDiagnosticService;
        _studentSkillAssessmentService = studentSkillAssessmentService;
        _graphQLResponseUnwrapper = graphQLResponseUnwrapper;
    }

    public async Task<IEnumerable<Guid>> GetNcDiagnosticsAsync(DateTime lastRunTime, DateTime currentTime)
    {
        CompletedStudentSkillDiagnosticsFilterInput filter = new(
            CompletedFrom: lastRunTime,
        CompletedTo: currentTime);

        var diagnostics = await _graphQLResponseUnwrapper.CallAsync(_studentSkillDiagnosticService.GetCompletedStudentSkillDiagnosticsAsync, filter);

        if (diagnostics == null || !diagnostics.Any())
        {
            _logger.LogInformation("No data returned from the GraphQL service for diagnostics");
            return Enumerable.Empty<Guid>();
        }

        var diagnosticsIds = diagnostics.Select(x => x.SessionId).ToHashSet();
        return diagnosticsIds;
    }

    public async Task<IEnumerable<Guid>> GetNcAssessmentsAsync(DateTime lastRunTime, DateTime currentTime)
    {
        CompletedStudentSkillAssessmentsFilterInput filter = new(
            CompletedFrom: lastRunTime,
        CompletedTo: currentTime);

        var assessments = await _graphQLResponseUnwrapper.CallAsync(_studentSkillAssessmentService.GetCompletedStudentSkillAssessmentsAsync, filter);

        if (assessments == null || !assessments.Any())
        {
            _logger.LogInformation("No data returned from the GraphQL service for assessments");
            return Enumerable.Empty<Guid>();
        }
        var assessmentIds = assessments.Select(x => x.SessionId).ToHashSet();

        return assessmentIds;
    }
}
```

**Pattern notes:**
- Injects `IGraphQLResponseUnwrapper` plus domain-specific GraphQL service interfaces.
- Each method: build filter -> call via `_graphQLResponseUnwrapper.CallAsync` -> null/empty check -> log -> return projected result.
- Empty-result guard pattern is identical across all methods.

---

### 1.5 IDataService.cs

```csharp
namespace NewClassrooms.AssessmentAuditor.Business.NcData
{
    public interface IDataService
    {
        Task<IEnumerable<Guid>> GetNcDiagnosticsAsync(DateTime lastRunTime, DateTime currentTime);
        Task<IEnumerable<Guid>> GetNcAssessmentsAsync(DateTime lastRunTime, DateTime currentTime);
    }
}
```

---

## 2. AssignmentChecker

### 2.1 Function.cs -- Entry Point

```csharp
using Amazon.Lambda.Annotations;
using Amazon.Lambda.Core;
using Microsoft.Extensions.Logging;
using NewClassrooms.AssignmentChecker.Business;
using NewClassrooms.Shared.Events.Payloads;
using NewClassrooms.Shared.Logging;

[assembly: LambdaSerializer(typeof(Amazon.Lambda.Serialization.SystemTextJson.DefaultLambdaJsonSerializer))]

namespace NewClassrooms.AssignmentChecker;

public class Function
{
    private readonly ILogger<Function> _logger;
    private readonly Engine _engine;

    public Function(ILogger<Function> logger, Engine engine)
    {
        _logger = logger;
        _engine = engine;
    }

    [LambdaFunction]
    public async Task Handle(SkillStatesPayload input, ILambdaContext context)
    {
        _logger.LogInformation($"Function called with {context.AwsRequestId}");

        try
        {
            await _engine.RunAsync(input);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex.Message, ex);
        }
    }
}
```

**Pattern notes:**
- Identical structure to AssessmentAuditor's `Function.cs`.
- Only difference: `Handle` accepts `SkillStatesPayload input` (event-driven Lambda triggered by SQS/Kinesis/EventBridge) vs `ILambdaContext` only.

---

### 2.2 Startup.cs -- DI Configuration

```csharp
using Amazon.Lambda.Annotations;
using Microsoft.Extensions.DependencyInjection;
using NewClassrooms.AssignmentChecker.Business;
using NewClassrooms.AssignmentChecker.Business.NcData;
using NewClassrooms.GraphQLClient.Authentication;
using NewClassrooms.GraphQLClient.IServices;
using NewClassrooms.GraphQLClient.Services;
using NewClassrooms.Shared.Authentication;
using NewClassrooms.Shared.Environment;

namespace NewClassrooms.AssignmentChecker
{
    [LambdaStartup]
    public class Startup : Shared.Environment.Startup
    {
        public Startup() : base(new HashSet<string>
        {
            nameof(LambdaEnvironment.GraphQlServerUrl),
        })
        {
        }

        public override void ConfigureServices(IServiceCollection services)
        {
            base.ConfigureServices(services);
            services
                .AddSingleton<AwsSecretProvider>()
                .AddSingleton(Environment)
                .AddScoped<IGraphQLResponseUnwrapper, GraphQLResponseUnwrapper>()
                .AddScoped<IStudentService, StudentService>()
                .AddScoped<IAssignmentService, AssignmentService>()
                .AddScoped<IDataService, DataService>()
                .AddScoped<Engine>()
                .AddHttpContextAccessor()
                .AddGraphQLClientWithAuth(client => client.BaseAddress = new Uri(Environment.GraphQlServerUrl), Application);
        }
    }
}
```

**Pattern notes:**
- Identical shape: `[LambdaStartup]`, inherits `Shared.Environment.Startup`, validates env vars, fluent service registration.
- Fewer dependencies: no Learnosity, no Kinesis, no CloudWatch, no `IEventSender` registrations.

---

### 2.3 Engine.cs -- Business Logic Delegation

```csharp
using Microsoft.Extensions.Logging;
using NewClassrooms.AssignmentChecker.Business.NcData;
using NewClassrooms.Shared.Entities;
using NewClassrooms.Shared.Events;
using NewClassrooms.Shared.Events.Payloads;

namespace NewClassrooms.AssignmentChecker.Business;

public class Engine
{
    private readonly ILoggerFactory _loggerFactory;
    private readonly ILogger<Engine> _logger;
    private readonly IDataService _dataService;

    public Engine(
        ILoggerFactory loggerFactory,
        IDataService dataService
        )
    {
        _loggerFactory = loggerFactory;
        _logger = _loggerFactory.CreateLogger<Engine>();
        _dataService = dataService;
    }

    public async Task RunAsync(SkillStatesPayload input)
    {
        var runTime = DateTime.UtcNow;

        PayloadValidator.ValidatePayload(input);

        _logger.LogInformation("SkillStatesPayload validated");

        var ssaTemp = await _dataService.GetStudentSkillAssignmentsAsync(input.StudentId, input.UpdatedSkillStates);

        _logger.LogInformation(
             "Fetched student skill assignments. StudentId: {StudentId}, Count: {Count}",
             input.StudentId,
             ssaTemp?.Count()
        );

        var studentSkillAssignments = ssaTemp
            .Where(ssa => (ssa.Assignment.DueOn > runTime) && ssa.Assignment.StartedOn < runTime)
            .Aggregate(new Dictionary<int, List<StudentSkillAssignment>>(), (dict, ssa) =>
            {
                if (dict.ContainsKey(ssa.Skill.Id))
                {
                    dict[ssa.Skill.Id].Add(ssa);
                }
                else
                {
                    dict[ssa.Skill.Id] = [ssa];
                }
                return dict;
            });

        _logger.LogInformation(
            "Grouped student skill assignments by skill. Total skills: {SkillCount}",
            studentSkillAssignments.Count
        );

        var studentSkills = await _dataService.GetStudentSkillsAsync(input.StudentId, input.UpdatedSkillStates);

        _logger.LogInformation(
            "Fetched student skills. StudentId: {StudentId}, Count: {Count}",
            input.StudentId,
            studentSkills?.Count()
        );

        IEnumerable<int> completedSkillStates = [
            (int)Shared.Enums.SkillState.Inferred,
            (int)Shared.Enums.SkillState.Passed,
            (int)Shared.Enums.SkillState.NotPassed,
            (int)Shared.Enums.SkillState.Discrepancy,
        ];

        foreach (var studentSkill in studentSkills.Where(ss => completedSkillStates.Contains(ss.SkillSubstate.SkillState.Id)))
        {
            var inferred = studentSkill.SkillSubstate.Id == (int)Shared.Enums.SkillSubstate.InferredViaAssessment;

            foreach (var studentSkillAssignment in studentSkillAssignments.GetValueOrDefault(studentSkill.Skill.Id, []))
            {
                _logger.LogInformation(
                    "Marking assigned skill {SkillId} complete for student {StudentId}. Inferred = {Inferred}",
                    studentSkillAssignment.Skill.Id, studentSkillAssignment.User.Id, inferred);
                await _dataService.MarkStudentSkillAssignmentCompleteAsync(studentSkillAssignment.Id, inferred ? null : studentSkill.SkillAssessment.Id);

                _logger.LogInformation(
                    "Assignment marked complete. AssignmentId: {AssignmentId}",
                    studentSkillAssignment.Id
                );
            }
        }
    }
}
```

**Pattern notes:**
- Same constructor pattern: `ILoggerFactory` + domain dependencies.
- `RunAsync(SkillStatesPayload input)` -- takes payload (event-driven) vs parameterless (timer-driven).
- Same XML doc anti-pattern note about not using in tests.

---

### 2.4 DataService.cs -- GraphQL Client Wrapper

```csharp
using Microsoft.Extensions.Logging;
using NewClassrooms.GraphQLClient.IServices;
using NewClassrooms.Shared.Entities;
using NewClassrooms.Shared.GraphQL.GlobalId;

namespace NewClassrooms.AssignmentChecker.Business.NcData;

public class DataService : IDataService
{
    private readonly IAssignmentService _assignmentService;
    private readonly IStudentService _studentService;
    private readonly ILogger<DataService> _logger;
    private readonly IGraphQLResponseUnwrapper _graphQLResponseUnwrapper;

    public DataService(IAssignmentService assignmentService, ILogger<DataService> logger, IGraphQLResponseUnwrapper graphQLResponseUnwrapper, IStudentService studentService)
    {
        _assignmentService = assignmentService;
        _logger = logger;
        _graphQLResponseUnwrapper = graphQLResponseUnwrapper;
        _studentService = studentService;
    }

    public async Task<IEnumerable<StudentSkillAssignment>> GetStudentSkillAssignmentsAsync(string studentId, List<string> skillIds)
    {
        var studentSkillAssignments = await _graphQLResponseUnwrapper.CallAsync(
            (studentId, skillIds) => _assignmentService.GetStudentSkillAssignmentsAsync(studentId, skillIds),
            studentId, skillIds);

        if (studentSkillAssignments == null || !studentSkillAssignments.Any())
        {
            _logger.LogInformation("No data returned from the GraphQL service for student skill assignments");
            return Enumerable.Empty<StudentSkillAssignment>();
        }

        return studentSkillAssignments;
    }

    public async Task<IEnumerable<StudentSkill>> GetStudentSkillsAsync(string studentId, IEnumerable<string> skillIds)
    {
        var studentSkills = await _graphQLResponseUnwrapper.CallAsync(_studentService.GetStudentSkillsAsync, studentId, new Shared.Filters.SkillStatesByStudentIdFilterInput
        {
            SkillIds = skillIds.Select(id => GlobalId.ExtractId(id)),
        });

        if (studentSkills == null || !studentSkills.Any())
        {
            _logger.LogInformation("No data returned from the GraphQL service for student skills");
            return Enumerable.Empty<StudentSkill>();
        }

        return studentSkills;
    }

    public async Task<StudentSkillAssignment> MarkStudentSkillAssignmentCompleteAsync(int studentSkillAssignmentId, int? studentSkillAssessmentId)
    {
        return await _graphQLResponseUnwrapper.CallAsync(() => _assignmentService.MarkStudentSkillAssignmentCompleteAsync(studentSkillAssignmentId, studentSkillAssessmentId));
    }
}
```

**Pattern notes:**
- Identical wrapper pattern: inject `IGraphQLResponseUnwrapper` + domain GraphQL services.
- Identical null/empty guard + log + return pattern.

---

### 2.5 IDataService.cs

```csharp
using NewClassrooms.Shared.Entities;

namespace NewClassrooms.AssignmentChecker.Business.NcData;

public interface IDataService
{
    Task<IEnumerable<StudentSkillAssignment>> GetStudentSkillAssignmentsAsync(string studentId, List<string> skillIds);
    Task<IEnumerable<StudentSkill>> GetStudentSkillsAsync(string studentId, IEnumerable<string> skillIds);
    Task<StudentSkillAssignment> MarkStudentSkillAssignmentCompleteAsync(int studentSkillAssignmentId, int? studentSkillAssessmentId);
}
```

---

## 3. Side-by-Side Comparison

### 3.1 What Is Identical

| Aspect | AssessmentAuditor | AssignmentChecker | Match |
|--------|-------------------|-------------------|-------|
| **File layout** | `Function.cs`, `Startup.cs`, `Business/Engine.cs`, `Business/NcData/DataService.cs`, `Business/NcData/IDataService.cs` | Same exact layout | 100% |
| **Function class structure** | `ILogger<Function>` + `Engine` injected; `[LambdaFunction]` on `Handle`; try/catch wrapper | Same | 100% |
| **Startup inheritance** | Inherits `Shared.Environment.Startup` with `[LambdaStartup]` | Same | 100% |
| **Startup env validation** | `HashSet<string>` of required `LambdaEnvironment` property names | Same | 100% |
| **DI registration style** | Fluent `services.AddSingleton/AddScoped` chain ending with `AddGraphQLClientWithAuth` | Same | 100% |
| **Engine constructor pattern** | `ILoggerFactory` injected, creates `ILogger<Engine>` via factory | Same | 100% |
| **Engine.RunAsync remark** | "Don't use this in your tests" XML doc | Same | 100% |
| **DataService pattern** | Injects `IGraphQLResponseUnwrapper` + domain GraphQL services; wraps calls; null-guard + log | Same | 100% |
| **Assembly attribute** | `[assembly: LambdaSerializer(...)]` | Same | 100% |
| **Using statements** | `Amazon.Lambda.Annotations`, `Amazon.Lambda.Core`, `Microsoft.Extensions.Logging`, `NewClassrooms.Shared.Logging` | Same | 100% |

### 3.2 What Differs

| Aspect | AssessmentAuditor | AssignmentChecker |
|--------|-------------------|-------------------|
| **Trigger type** | Timer/scheduled (no payload) | Event-driven (`SkillStatesPayload`) |
| **Function.Handle signature** | `Handle(ILambdaContext context)` | `Handle(SkillStatesPayload input, ILambdaContext context)` |
| **Engine.RunAsync signature** | `RunAsync()` | `RunAsync(SkillStatesPayload input)` |
| **External integrations** | Learnosity API, Kinesis, CloudWatch | None (only GraphQL) |
| **GraphQL services consumed** | `IStudentSkillDiagnosticService`, `IStudentSkillAssessmentService` | `IAssignmentService`, `IStudentService` |
| **DataService methods** | Read-only queries (`GetNcDiagnosticsAsync`, `GetNcAssessmentsAsync`) | Read + write (`GetStudentSkillAssignmentsAsync`, `GetStudentSkillsAsync`, `MarkStudentSkillAssignmentCompleteAsync`) |
| **Env vars required** | `GraphQlServerUrl`, `KinesisEventStreamArn` | `GraphQlServerUrl` only |
| **Business logic** | Compares Learnosity vs NC data; publishes missing events to Kinesis | Validates skill state changes; marks assignments complete |
| **Return types** | `IEnumerable<Guid>` (session IDs) | Domain entities (`StudentSkillAssignment`, `StudentSkill`) |

### 3.3 Structural Pattern Summary

```
+----------------------------------+
|  Function.cs                     |
|  - [LambdaFunction] Handle(...)  |
|  - Injects: ILogger, Engine      |
|  - Delegates to Engine.RunAsync  |
+----------------------------------+
              |
              v
+----------------------------------+
|  Startup.cs                      |
|  - [LambdaStartup]               |
|  - Inherits Shared.Environment   |
|    .Startup                      |
|  - Validates env vars            |
|  - Registers:                    |
|    * Singletons (config, secrets)|
|    * Scoped GraphQL services     |
|    * Scoped AWS SDK clients      |
|    * IDataService -> DataService |
|    * Engine                      |
|    * AddGraphQLClientWithAuth    |
+----------------------------------+
              |
              v
+----------------------------------+
|  Engine.cs                       |
|  - Injects: ILoggerFactory +     |
|    domain services               |
|  - RunAsync(...)                 |
|  - Orchestrates business flow    |
+----------------------------------+
              |
              v
+----------------------------------+
|  DataService.cs                  |
|  - Implements IDataService       |
|  - Injects: IGraphQLResponse     |
|    Unwrapper + domain services   |
|  - Wraps GraphQL calls with      |
|    null-guard + logging          |
+----------------------------------+
```

---

## 4. Recommendation: Merge Into Shared Generic Lambda Framework

### 4.1 Evidence for Merging

1. **Identical scaffolding:** The `Function`, `Startup`, `Engine`, and `DataService` structural patterns are copy-paste identical. Any bug fix or improvement to one (e.g., better exception handling in `Function.Handle`, adding correlation ID logging) must be manually replicated to the other.

2. **Only business logic differs:** The differences are entirely in the domain-specific interfaces injected into `Engine` and `DataService`, and the payload type accepted by `Function.Handle`. These are perfect candidates for generic abstractions.

3. **Shared.Environment.Startup already exists:** The codebase already recognizes the commonality by providing a base `Startup` class. This should be extended to cover the full pattern.

### 4.2 Proposed Generic Framework

```csharp
// Shared.LambdaFramework

public abstract class LambdaFunction<TPayload>
{
    protected readonly ILogger Logger;
    protected readonly ILambdaEngine<TPayload> Engine;

    protected LambdaFunction(ILogger logger, ILambdaEngine<TPayload> engine)
    {
        Logger = logger;
        Engine = engine;
    }

    public async Task HandleAsync(TPayload input, ILambdaContext context)
    {
        Logger.LogInformation("Function called with {AwsRequestId}", context.AwsRequestId);
        try
        {
            await Engine.RunAsync(input);
        }
        catch (Exception ex)
        {
            Logger.LogError(ex, ex.Message);
        }
    }
}

public interface ILambdaEngine<TPayload>
{
    Task RunAsync(TPayload input);
}

public abstract class LambdaDataService
{
    protected readonly IGraphQLResponseUnwrapper Unwrapper;
    protected readonly ILogger Logger;

    protected LambdaDataService(IGraphQLResponseUnwrapper unwrapper, ILogger logger)
    {
        Unwrapper = unwrapper;
        Logger = logger;
    }

    protected async Task<T> QueryAsync<T>(Func<Task<T>> query, string entityName)
    {
        var result = await Unwrapper.CallAsync(query);
        if (result == null || (result is IEnumerable enumerable && !enumerable.Cast<object>().Any()))
        {
            Logger.LogInformation("No data returned from the GraphQL service for {EntityName}", entityName);
            return default;
        }
        return result;
    }
}
```

### 4.3 What Would Remain Per-Service

| Component | Generic Framework | Per-Service |
|-----------|-------------------|-------------|
| Entry point wrapper | `LambdaFunction<TPayload>` | Concrete class inheriting + `[LambdaFunction]` attribute |
| DI registration | Base `Startup` + extension methods | Domain-specific service registrations only |
| Business orchestration | `ILambdaEngine<TPayload>` interface | Concrete `Engine` implementing the interface |
| GraphQL wrapper | `LambdaDataService` base class | Concrete `DataService` with domain methods |
| Payload type | Generic `TPayload` | `SkillStatesPayload`, `Unit` (for timer), etc. |

### 4.4 Risk Assessment

| Risk | Mitigation |
|------|------------|
| Breaking existing Lambdas | Introduce framework alongside existing code; migrate one at a time |
| Over-abstraction | Keep framework minimal; only extract truly identical scaffolding |
| Testing disruption | Generic base classes are easier to mock; improves testability |
| Deployment complexity | No change to deployment; only code organization |

---

## 5. File Paths

- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/assessment-auditor/Nc.AssessmentAuditor/Function.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/assessment-auditor/Nc.AssessmentAuditor/Startup.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/assessment-auditor/Nc.AssessmentAuditor.Business/Engine.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/assessment-auditor/Nc.AssessmentAuditor.Business/NcData/DataService.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/assessment-auditor/Nc.AssessmentAuditor.Business/NcData/IDataService.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/assignment-checker/Nc.AssignmentChecker/Function.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/assignment-checker/Nc.AssignmentChecker/Startup.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/assignment-checker/Nc.AssignmentChecker.Business/Engine.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/assignment-checker/Nc.AssignmentChecker.Business/NcData/DataService.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/assignment-checker/Nc.AssignmentChecker.Business/NcData/IDataService.cs`

