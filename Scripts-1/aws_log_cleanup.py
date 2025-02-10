import boto3
from datetime import datetime, timedelta

# Initialize Cloudwatch Logs Client
client = boto3.client('logs')

# Define log group and retention period
log_group = "/aws/lambda/my-func"
days_to_keep = 30
cutoff_date = datetime.utcnow() - timedelta(days=days_to_keep)

# Get log streams
streams = client.describe_log_streams(logGroupName=log_group)['logStreams']

# Delete old log streams
for stream in streams:
    if 'lastEventTimestamp' in stream:
        last_event_time = datetime.utcfromtimestamp(stream['lastEventTimeStamp'] / 100)
        if last_event_time < cutoff_date:
            print(f"Deleting log stream: {stream['logStreamName']}")
            client.delete_log_stream(logGroupName=log_group, logStreamName=stream['logStreamName'])

# This pyscript will help to clean up unused Cloudwatch logs which are present more than 30 days to avoid increasing cossts.
# 1. First it will fetch all the logstreams from the Cloudwatch.
# 2. Then filters logs older than 30 days
# 3, Deletes them to reduce storage costs.