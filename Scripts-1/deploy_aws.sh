#!/bin/bash

# Variables
TF_DIR = "terraform-infra"
AWS_REGION = "us-east-1"

# Check if Terraform is installed
if ! command -v terraform &> /dev/null
then
    echo "Terraform is not installed! Exiting...."
    exit 1
fi

# Navigate to Terraform directory
cd $TF_DIR ||  { echo "Directory not found! Exiting..."; exit 1; }

# Initialise Terraform
terraform init

# Validate the Terraform Code
terraform validate
if [ $? -ne 0 ]; then
    echo "Terraform Validation Failed! Exiting..."
    exit 1
fi

# Apply the Terraform plan
terraform apply --auto-approve
if [ $? -eq 0 ]; then
    echo "Terraform Deployment Successful!!"
    exit 1
else
    echo "Terraform Deployment Failed!!"
fi


# The above script helps in automating AWS Resource Provisioning using Terraform and Bash.
# 1. Starts with checking if Terraform is Installed.
# 2. Then Navigates to the Terraform Project Directory.
# 3. Initializes and validates the Terraform Script.
# 4. Then applies the Terraform plan to deploy the Infrastructure.