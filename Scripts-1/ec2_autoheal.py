import boto3

# AWS Configuration
region = "us-east-1"
instance_id = "instance-id" # Update with your instance id

ec2 = boto3.client('ec2', region_name=region)

# Check instance health
status = ec2.describe_instance_status(InstanceIds=[instance_id])['InstanceStatuses']

if not status or status[0]['InstanceState']['Name'] != "running":
    print(f"Instance {instance_id} is not running. Restarting...")
    ec2.stop_instances(InstanceIds=[instance_id])
    ec2.start_instances(InstanceIds=[instance_id])
else:
    print("Instance {instance_id} is healthy.")


# THis script helps to stop and start if an EC2 instance goes into unhealthy state.
# 1. It checks the EC2 instances health using AWS APIs.
# 2. If it sees the instance state is unhealthy, it automatically restarts it.