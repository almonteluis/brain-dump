---
description: "How to run the QA frontend automated test workflow - Quality Assurance"
tags: ['research']
source: "https://newclassrooms.atlassian.net/wiki/spaces/QA/pages/652148740/How+to+run+the+QA+frontend+automated+test+workflow"
raw_file: "How to run the QA frontend automated test workflow - Quality Assurance 1.md"
created: 2026-05-17
---

## How to run the QA frontend automated test workflow

## Overview

The frontend test automation suite has its own GitHub Actions workflow to allow users to define the branch they want to use, how many times to run the tests and which environment the tests will run against.

See notes on [what the tests cover here](https://newclassrooms.atlassian.net/wiki/spaces/QA/pages/1641283602 "https://newclassrooms.atlassian.net/wiki/spaces/QA/pages/1641283602").

## Basic process

To run the workflow, complete the following steps:

1. Go to the [qa-frontend-automation workflow](https://github.com/NewClassrooms/qa-frontend-automated-tests/actions/workflows/application-frontend-test.yaml "https://github.com/NewClassrooms/qa-frontend-automated-tests/actions/workflows/application-frontend-test.yaml") (which is an action in the [qa-frontend-automated-tests](https://github.com/NewClassrooms/qa-frontend-automated-tests "https://github.com/NewClassrooms/qa-frontend-automated-tests") repo).
2. On the right side of the page, click on the *Run workflow* button in the blue box.
3. In the resulting modal, make the applicable selections:
	1. The branch of the `qa-frontend-automated-tests` repo to run. Leave this as `main` unless you are testing the tests themselves in a branch in that repo.
		2. The number of times to run the tests. Leave this at 1 unless you have a specific need.
		3. The environment to test against, where you have presumably already deployed your code.
		![image-20250203-215300.png](blob:https://newclassrooms.atlassian.net/ee497608-a5da-4cfd-9471-db46055765a6#media-blob-url=true&id=3d322769-4ed0-44ac-a2e9-af7b94fb58b2&collection=contentId-652148740&contextId=652148740&mimeType=image%2Fpng&name=image-20250203-215300.png&size=16140&width=314&height=272&alt=image-20250203-215300.png&clientId=9fd199b9-f5f0-40a6-8c09-0dbb77bcfee5)
		**NOTE:** To ensure suite reliability after each automation ticket, it is best practice to run the test suite at least five times.
4. Click on the *Run workflow* button. It will take about three minutes to run **just the deployment of the task**. You can watch this by refreshing the workflow page and clicking on your run.
5. Once the task has deployed, you can to some extent monitor the running progress in CloudWatch Logs Insights. You’ll need to just find the right log group (for example, `/ecs/tto-deveng-use2-bear-qa-frontend-automation`) and search in a reasonable timeframe (e.g. the past hour). Just keep in mind that it takes roughly **five minutes for logs to show up** in CloudWatch.
6. Once the task starts, a notifcation will be sent to [#test-automation-workflow-results](https://newclassrooms.slack.com/archives/C07Q40Y2PL2 "https://newclassrooms.slack.com/archives/C07Q40Y2PL2") indicating that the test run has started
7. **After about 20 minutes**, a follow-up notification will be sent that includes a basic pass/fail indication and the `s3://` link to the bucket with the results. You can download the `index.html` file from there to view the details. See: [How to find Automated Tests result on AWS](https://newclassrooms.atlassian.net/wiki/spaces/QA/pages/810876931)

## Troubleshooting

The logs for the running ECS task can be found in the target environment’s AWS account. Look in CloudWatch Logs Insights, and find the appropriate log group, e.g. `/ecs/tto-deveng-use2-bear-qa-frontend-automation`. (Just typing `frontend` will probably get you the right autocomplete result.)
