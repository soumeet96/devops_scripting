#!/bin/bash

# Variable
NAMESPACE = "default"
POD_NAME = "my-app"

# Check if the Pod is running.
if ! kubectl get pods -n $NAMESPACE | grep -q  "$POD_NAME.*Running"; then
    echo "Pod $POD_NAME is not running. Restarting..."
    kubectl delete pod $POD_NAME -n $NAMESPACE
fi

# The above script helps to Auto Recover the Kubernetes Pod.
# 1. It will check if the Pod is running in the given Namespace.
# 2. If the Pod is not running then it will delete the Pod so that Kubernetes can restart automatically.
