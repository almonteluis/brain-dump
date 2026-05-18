---
description: "Logging - Marvin"
tags: ["marvin", "new-classrooms", "engineering"]
source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261391/Logging"
raw_file: "Logging - Marvin.md"
created: 2026-05-17
---

## Logging

Logging is a critical tool for both understanding the current functioning of our products and analyzing past behavior, both in deployed environments and during local development. Construct your logs with this in mind!

## Development perspective

Any codebases in which it's feasible should **use a standard or widely-used logging library** (e.g. C# `log4net`, Python `logging`). These libraries support logging concurrently to multiple sinks in multiple formats, with rich and dynamic configurability.

**Avoid writing directly to stdout/stderr.** Of course, feel free to do it, just don't commit it.

Use logging levels (DEBUG, INFO, WARNING, ERROR, FATAL) mindfully. Presume that **only INFO and above will be logged in production and staging** environments. Lower levels may be activated in dev/test/local environments but should be easily configured (e.g. a command-line flag or environment variable). Please do not use TRACE or CRITICAL (the latter being more or less a Python synonym for FATAL).

Make sure that your logging library is capable of **logging structured data** in JSON format (e.g. `log4net.Ext.Json`, `python-json-logger`, `structlog`). Of course a stdout-style log sink should be able to still print ordinary, single-line messages from that data.

Log messages should be **concise and self-contained**; ==they should not refer to preceding or successive messages== (e.g. breaking a long message across multiple "lines" that end up being multiple entries in the log).

**good**

```
2021-06-15 05:42:10,806 DEBUG: Processing started for students 123, 124, 125, 126
```

**bad**

```
2021-06-15 05:42:10,806 DEBUG: Processing started for students:

2021-06-15 05:42:10,806 DEBUG:     123, 124, 125, 126
```

The latter looks okay in context but is meaningless without knowing exactly what log message preceded it.

Timestamps should have a reasonable level of precision. Seconds or at most milliseconds is likely to be all we want. Extra digits for microseconds are noise. **Use ISO-8601 format and UTC** (`2022-12-02T12:29:28Z` or `%Y-%m-%dT%H:%M:%SZ`). You are free to log in a local time zone for development purposes, but messages going out to other log handlers need to be in UTC for the sake of easy comparison and interoperability.

==Variable data== must be clearly delimited in order to prevent confusing messages when that data is blank or null. Data that is guaranteed to not be blank or null or otherwise cause confusion doesn't need to be delimited. For example, `"Scheduling complete for school '{school_name}'"` but `"Student {student_id} schedule updated"`.

## Nc.Shared C# logging documentation

There is quite a bit of documentation available in the Marvin shared subdir about how to work with logging in our C# projects:

[https://github.com/NewClassrooms/marvin/blob/main/shared/Nc.Shared/README.Logging.md](https://github.com/NewClassrooms/marvin/blob/main/shared/Nc.Shared/README.Logging.md "https://github.com/NewClassrooms/marvin/blob/main/shared/Nc.Shared/README.Logging.md")

## Personally Identifiable Information (PII)

Do **not** send any user's personally identifiable information to the logs.

Our definition of PII is the following (as stored in the database, if you are working with data in graphQL structures, the node attributes should be similarly named):

- users.first\_name
- users.last\_name
- users.email

To identify a specific user, please use their internal id (users.id) or the id we use as a key to external systems (users.public\_user\_id).

## Infrastructure perspective

Plan to log to CloudWatch. You may have the choice of explicitly using a package that logs to CloudWatch (e.g. Python `boto3`), or you may end up in a situation where the only convenient method is to have stdout/stderr go directly to CloudWatch. In the latter case, ensure that your log messages are in JSON format, digestible by tools like CloudWatch Insights or Grafana.

Log level should be configurable at deployment time or via the console, for example through an environment variable. We don't *want* to be generally logging at TRACE level in the dev/test environment (let alone production), but having the option to enable it without disruption is important.

**Log timestamps should be in UTC.**

Using structured logs allows us to take advantage of filters in CloudWatch Insights. For example:

```
fields @timestamp, @logStream, @log, message

| filter log_level == "DEBUG" and entity.id == 234

| sort @timestamp desc

| limit 20
```

The fields prefixed with `@` are native to CloudWatch; the other fields (e.g. message, log\_level, entity.id) are "discovered" fields that are extracted automatically from our structured logs.

If you want to directly experiment with this in AWS, log into the scratch account, make a log group and log stream for yourself, head to [Log Insights](https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#logsV2:logs-insights "https://us-east-1.console.aws.amazon.com/cloudwatch/home?region=us-east-1#logsV2:logs-insights"), and put some log events into your stream:

```
aws --profile nc_scratch logs put-log-events --log-group-name logging-test --log-stream-name foo \

    --log-events timestamp=$(date +%s)000,message="$(jq -c . message.json | jq -R .)"
```

Please tag your resources appropriately and clean up after yourself, as always.

## Log levels

This is a rough description of how log levels should be used. We may need to periodically norm on this, updating various codebases to keep them in line with our actual use cases.

<table><colgroup><col> <col> <col></colgroup><tbody><tr><th rowspan="1" colspan="1"><div><p><strong>Level</strong></p><figure></figure></div></th><th rowspan="1" colspan="1"><div><p><strong>Usage</strong></p><figure></figure></div></th><th rowspan="1" colspan="1"><div><p><strong>Examples</strong></p><figure></figure></div></th></tr></tbody></table>

<table><colgroup><col> <col> <col></colgroup><tbody><tr><th rowspan="1" colspan="1"><div><p><strong>Level</strong></p><figure></figure></div></th><th rowspan="1" colspan="1"><div><p><strong>Usage</strong></p><figure></figure></div></th><th rowspan="1" colspan="1"><div><p><strong>Examples</strong></p><figure></figure></div></th></tr><tr><td rowspan="1" colspan="1"><p>DEBUG</p></td><td rowspan="1" colspan="1"><p>For detailed information useful in troubleshooting issues but otherwise not of interest to someone looking to understand the general behavior of the system.</p></td><td rowspan="1" colspan="1"><ul><li><p>Database query took 200ms to execute.</p></li><li><p>GraphQL service returned 11939 bytes.</p></li></ul></td></tr><tr><td rowspan="1" colspan="1"><p>INFO</p></td><td rowspan="1" colspan="1"><p>For reporting the ordinary functioning of the system. Can be useful for troubleshooting, but ballpark should be perhaps 1/10th the volume of DEBUG messages.</p></td><td rowspan="1" colspan="1"><ul><li><p>Scheduler running for section 42.</p></li><li><p>Scheduling complete for section 42.</p></li></ul></td></tr><tr><td rowspan="1" colspan="1"><p>WARNING</p></td><td rowspan="1" colspan="1"><p>Something happened that perhaps shouldn't happen but was anticipated, and there is no danger to the functioning of the application. May eventually require investigation.</p></td><td rowspan="1" colspan="1"><ul><li><p>Tried to run scheduler for a section that has zero students in it.</p></li><li><p>Had to retry connection to data layer.</p></li></ul></td></tr><tr><td rowspan="1" colspan="1"><p>ERROR</p></td><td rowspan="1" colspan="1"><p>Something bad happened, but the application was able to continue in a coherent way. Someone should look into it and see about preventing it in the future.</p></td><td rowspan="1" colspan="1"><ul><li><p>Tried to run scheduler for nonexistent section 123.</p></li></ul></td></tr><tr><td rowspan="1" colspan="1"><p>FATAL</p></td><td rowspan="1" colspan="1"><p>It broke. The application can't continue in any sane way. Someone should probably hop on this right away.</p></td><td rowspan="1" colspan="1"><ul><li><p>Scheduler unable to connect to GraphQL service after 5 retries.</p></li></ul></td></tr></tbody></table>

## JSON format

## Fields

<table><colgroup><col> <col> <col> <col> <col></colgroup><tbody><tr><th rowspan="1" colspan="1"><div><p><strong>Field</strong></p><figure></figure></div></th><th rowspan="1" colspan="1"><div><p><strong>Required</strong></p><figure></figure></div></th><th rowspan="1" colspan="1"><div><p><strong>Type</strong></p><figure></figure></div></th><th rowspan="1" colspan="1"><div><figure></figure></div></th><th rowspan="1" colspan="1"><div><p><strong>Example</strong></p><figure></figure></div></th></tr></tbody></table>

<table><colgroup><col> <col> <col> <col> <col></colgroup><tbody><tr><th rowspan="1" colspan="1"><div><p><strong>Field</strong></p><figure></figure></div></th><th rowspan="1" colspan="1"><div><p><strong>Required</strong></p><figure></figure></div></th><th rowspan="1" colspan="1"><div><p><strong>Type</strong></p><figure></figure></div></th><th rowspan="1" colspan="1"><div><figure></figure></div></th><th rowspan="1" colspan="1"><div><p><strong>Example</strong></p><figure></figure></div></th></tr><tr><td rowspan="1" colspan="1"><p>timestamp</p></td><td rowspan="1" colspan="1"><p>yes</p></td><td rowspan="1" colspan="1"><p>string</p></td><td rowspan="1" colspan="1"><p>Full ISO-8601 timestamp with time zone in UTC. A trailing <code>Z</code> with no time zone offset implies UTC. Fractional seconds are optional. Limit to four decimal places unless absolutely necessary. See <a href="https://www.rfc-editor.org/rfc/rfc3339#section-5.8">RFC 3339</a> for more information.</p></td><td rowspan="1" colspan="1"><p>2023-02-24T08:38:51Z</p></td></tr><tr><td rowspan="1" colspan="1"><p>log_level</p></td><td rowspan="1" colspan="1"><p>yes</p></td><td rowspan="1" colspan="1"><p>string</p></td><td rowspan="1" colspan="1"><p>One of: DEBUG, INFO, WARNING, ERROR, FATAL. Please do not use TRACE, CRITICAL, or any other levels, spellings, or capitalizations.</p></td><td rowspan="1" colspan="1"><p>INFO</p></td></tr><tr><td rowspan="1" colspan="1"><p>message</p></td><td rowspan="1" colspan="1"><p>yes</p></td><td rowspan="1" colspan="1"><p>string</p></td><td rowspan="1" colspan="1"><p>Concise description of what happened; recommended length less than 100 characters</p></td><td rowspan="1" colspan="1"><p>Student 123 assigned to location 456</p></td></tr><tr><td rowspan="1" colspan="1"><p>environment</p></td><td rowspan="1" colspan="1"><p>yes</p></td><td rowspan="1" colspan="1"><p>string</p></td><td rowspan="1" colspan="1"><p>Localhost, Development, Staging, Production</p></td><td rowspan="1" colspan="1"><p>Staging</p></td></tr><tr><td rowspan="1" colspan="1"><p>host</p></td><td rowspan="1" colspan="1"><p>no</p></td><td rowspan="1" colspan="1"><p>string</p></td><td rowspan="1" colspan="1"><p>Host name or IP address on which the message originated</p><p><em>Note that we originally had this as</em> required<em>, but in the context of running things in ECS and Lambda, it has much less value.</em></p></td><td rowspan="1" colspan="1"><p>10.0.1.10</p></td></tr><tr><td rowspan="1" colspan="1"><p>service</p></td><td rowspan="1" colspan="1"><p>no</p></td><td rowspan="1" colspan="1"><p>string</p></td><td rowspan="1" colspan="1"><p>What specific service (e.g. Scheduler, DailyAdjuster) originated the message. Roughly speaking, this should identify what codebase the message came from.</p><p><em>Note that we originally had this as</em> required<em>, but the service is generally one-to-one with the log group in AWS CloudWatch, so having it also appear in the log message has little value. Same with the Docker Compose stack, where the messages are prefixed with the service name.</em></p></td><td rowspan="1" colspan="1"><p>Scheduler</p></td></tr><tr><td rowspan="1" colspan="1"><p>category</p></td><td rowspan="1" colspan="1"><p>no</p></td><td rowspan="1" colspan="1"><p>string</p></td><td rowspan="1" colspan="1"><p>Further narrowing down source of message, e.g. subsystem, class name. Roughly, this could identify what file within a codebase the message came from.</p></td><td rowspan="1" colspan="1"><p>LocationAssigner</p></td></tr><tr><td rowspan="1" colspan="1"><p>exception</p></td><td rowspan="1" colspan="1"><p>no</p></td><td rowspan="1" colspan="1"><p>any</p></td><td rowspan="1" colspan="1"><p>Additional information about any error that occurred, e.g. the underlying exception that triggered this message. This could be a simple string message or an object with further structure, like an error code, message, and stack trace.</p></td><td rowspan="1" colspan="1"></td></tr><tr><td rowspan="1" colspan="1"><p>entity</p></td><td rowspan="1" colspan="1"><p>no</p></td><td rowspan="1" colspan="1"><p>object</p></td><td rowspan="1" colspan="1"><p>The specific data entity this message relates to. This field is somewhat speculative and subject to change or reinterpretation based on the uses we find for it.</p></td><td rowspan="1" colspan="1"><p>{"type": "Student", "id": 123}</p></td></tr></tbody></table>

## Example

```javascript
{

  "timestamp": "2023-02-24T08:50:30Z",

  "log_level": "INFO",

  "message": "Finished location assigner for student 234",

  "environment": "Staging",

  "service": "Steve testing",

  "host": "localhost",

  "entity": {

    "type": "Student",

    "id": 234

  }

}
```

## Future ideas

- Being able to analyze log messages by request or invocation
- Arbitrary tags (KVPs) for any message
- Splitting out log levels to different log streams so they can have different retention policy
