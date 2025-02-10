#!/bin/bash

ALERT_NAME="HighCPUUsage"
ALERTS=$(curl -s https://localhost:9093/api/v1/alerts | jq -r '.data[] | select(.labels.alertname=="'"$ALERT_NAME"'")')

if [[ ! -z "$ALERTS" ]]; then
    echo "High CPU USage detected! Scaling up the Application..."
    kubectl scale deployment my-app --replicas=5
else
    echo "No alert found. System is stable."
fi


# This script will help to scale up pods if there is a high CPU spike.
# 1. When there is an alert from Prometheus then this script will run.
# 2. It will Query the Prometheus Alertmanager API to check the high CPU Usage Alerts./
# 3. If an alert is found then it will auomatically scale up the deployment.