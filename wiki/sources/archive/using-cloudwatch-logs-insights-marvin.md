---
description: "Using CloudWatch Logs Insights - Marvin"
tags: ['research', 'marvin', 'new-classrooms']
source: "https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/699138058/Using+CloudWatch+Logs+Insights"
raw_file: "Using CloudWatch Logs Insights - Marvin.md"
created: 2026-05-17
---

## Using CloudWatch Logs Insights

## Overview

AWS CloudWatch Logs Insights is a flexible query interface for CloudWatch logs.

Find it at:

[https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#logsV2:logs-insights](https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#logsV2:logs-insights "https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#logsV2:logs-insights")

…or under *CloudWatch* > *Logs* > *Logs Insights* in the AWS console.

Queries can be [saved for future use](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_Insights-Saving-Queries.html "https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_Insights-Saving-Queries.html"), shared with others just in plain text form, [exported to CSV](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_ExportQueryResults.html "https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_ExportQueryResults.html"), and [added to CloudWatch dashboards](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_ExportQueryResults.html "https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_ExportQueryResults.html").

Note that **queries cost money to run**, and you should be as specific as reasonably possible in terms of choosing log groups and date ranges and such. See more guidance on cost control [here](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html "https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html").

## Examples

## Query BFF with no particular constraints

Select the `/aws/lambda/backend-for-frontend` log group and an appropriate time range where you expect to see results. The default query will look more or less as below.

**Query**

```
fields @timestamp, @message

| sort @timestamp desc

| limit 20
```

**Results**

![Screenshot from 2024-11-08 07-47-04.png](blob:https://newclassrooms.atlassian.net/64e5a235-fe38-4c2a-8bc1-1f14757a368c#media-blob-url=true&id=0d0bd227-02bd-440d-beb2-60d3b549d0f4&collection=contentId-699138058&contextId=699138058&width=1120&height=326&alt=Screenshot%20from%202024-11-08%2007-47-04.png&clientId=9fd199b9-f5f0-40a6-8c09-0dbb77bcfee5)

## Query GraphQL service for database queries

Select the appropriate log group for the service; there may be a few that look right, but the one you want should look like `/ecs/tto-{env_type}-use2-{env_name}-graphql-service`. Select an appropriate time range where you expect to see log entries.

**Query**

```
fields @timestamp, State.elapsed, State.commandText

| filter Category == 'Microsoft.EntityFrameworkCore.Database.Command'

| sort @timestamp desc

| limit 20
```

**Results**

## Query Inference Engine for basic log messages

Select the `/aws/lambda/inference-engine` log group and an appropriate date range where you expect to see messages.

**Query**

```
fields @timestamp, log_level, category, message

| filter ispresent(log_level) 

| sort @timestamp desc

| limit 20
```

**Results**

## Tips and tricks

## Discovered fields

Note that Logs Insights is very driven by its ability to “discover” fields inside the log messages. Those fields should show up in the little drawer on the right edge of the console.

If you are expecting a field somewhere in your JSON blob to be available, like `State.commandText` in the above GraphQL service example, sometimes it takes a while for Logs Insights to find it, and you will get blank results until it does.

It’s not clear there is anything you can do about this other than waiting or trying a couple of times.

## AWS documentation

- [Overview](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AnalyzingLogData.html "https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/AnalyzingLogData.html")
- [Sample queries by service](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax-examples.html "https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax-examples.html")
- [Query syntax](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html "https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/CWL_QuerySyntax.html")
