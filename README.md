# Task1



## Using Docker Compose

`docker compose up -d`

GitHub Actions Workflow Documentation for AWS Terraform Deployment
Prerequisites:
AWS Account with access to create resources.
Terraform configuration files (.tf files) ready to deploy to AWS.
GitHub Repository where you’ll configure your workflow.
GitHub Secrets configured for storing AWS credentials securely.
Step 1: AWS Credentials Setup
To authenticate with AWS, we’ll use AWS access keys. Ensure you have the following:

AWS Access Key ID
AWS Secret Access Key
Generate AWS Access Key
Navigate to the IAM Console in AWS.
Create a new IAM User (if you don’t have one) with programmatic access and attach a policy like AdministratorAccess or a custom policy that provides sufficient permissions for the Terraform deployment.
Download or copy the Access Key ID and Secret Access Key.
Store Credentials in GitHub Secrets
In your GitHub repository, go to Settings → Secrets and variables → Actions.
Click New repository secret.
Name the secrets as:
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
Add a third secret for the AWS Region if needed:
Name: AWS_REGION
Value: your region (e.g., us-east-1).
Step 2: Terraform Configuration
Make sure  repository has the Terraform files in the correct structure .



Step 3: GitHub Actions Workflow Setup
The GitHub Actions workflow will handle the automation of Terraform commands such as init, plan, and apply when code is pushed to the main branch.

Example GitHub Actions Workflow (YAML)
yaml
Copy code
name: aws-deployment

on:
  push:
    branches: [ "main" ]

  workflow_dispatch:

jobs:
  Terraform_apply:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Terraform hashicorp setup
        uses: hashicorp/setup-terraform@v2

      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1  # Change this to your AWS region

      - name: terraform init
        run: |
          cd Task2
          terraform init 

      - name: terraform plan
        run: |
          cd Task2
          terraform plan

      - name: terraform apply
        run: |
          cd Task2
          terraform apply -auto-approve
Workflow Breakdown
Workflow Trigger: The workflow is triggered when a push is made to the main branch or manually using the workflow_dispatch event.
Check Out Code: The actions/checkout@v3 action is used to fetch the repository's code.
Terraform Setup: The hashicorp/setup-terraform@v2 action sets up the Terraform CLI.
AWS Credentials Configuration: The aws-actions/configure-aws-credentials@v1 action configures the AWS credentials to authenticate with your AWS account.
Terraform Commands:
terraform init: Initializes Terraform in the Task2 directory.
terraform plan: Shows the execution plan.
terraform apply -auto-approve: Applies the changes automatically without waiting for manual approval.
Step 4: Testing the Workflow
Push Changes: After committing your Terraform and workflow files, push them to the main branch of your GitHub repository.
Monitor the Workflow:
Go to the Actions tab of your repository.
You should see the aws-deployment workflow running automatically.
You can follow the logs to ensure that the steps complete successfully.
Step 5: Manually Triggering the Workflow
In addition to automatic runs on push, you can manually trigger the workflow using the workflow_dispatch event:

Go to the Actions tab.
Find the aws-deployment workflow.
Click the Run workflow button and select the branch you want to run it on.
Conclusion
With this setup, every time you push changes to the main branch or manually trigger the workflow, GitHub Actions will automatically apply your Terraform configurations to AWS. Make sure to monitor the logs for any potential issues during the deployment.

This approach ensures a streamlined, automated CI/CD pipeline for deploying infrastructure on AWS using Terraform.






You said:
please create a readme file for this
ChatGPT said:
ChatGPT
Here's a README.md file that you can include in your repository to document the AWS Terraform deployment setup using GitHub Actions.

AWS Terraform Deployment with GitHub Actions
This repository contains an automated workflow for deploying AWS infrastructure using Terraform through GitHub Actions. The setup leverages AWS credentials and securely manages infrastructure changes on the AWS platform with Terraform.

Prerequisites
Before using this workflow, make sure you have the following:

AWS Account with access to create resources.
Terraform configuration files (e.g., main.tf) in your repository.
GitHub Secrets set up for storing AWS credentials securely.
Setup Instructions
1. Set Up AWS Credentials
Generate AWS Access Key
Log in to your AWS Management Console.
Navigate to IAM and create an IAM User with the following:
Programmatic access (enabling API calls).
Attach a policy with sufficient permissions (e.g., AdministratorAccess).
Save the Access Key ID and Secret Access Key securely.
Add Credentials to GitHub Secrets
In your GitHub repository, navigate to Settings → Secrets and variables → Actions.
Add the following repository secrets:
AWS_ACCESS_KEY_ID: Your AWS Access Key ID.
AWS_SECRET_ACCESS_KEY: Your AWS Secret Access Key.
AWS_REGION (optional): Your AWS region (e.g., us-east-1).
2. Terraform Directory Structure
Ensure that your Terraform configuration files are placed inside a directory (e.g., Task2). Below is an example structure:

plaintext
Copy code
.
├── .github/
│   └── workflows/
│       └── aws-deployment.yml
├── Task2/
│   └── main.tf
└── README.md
The aws-deployment.yml file is the GitHub Actions workflow.
The Task2 directory contains your Terraform configuration files.
3. GitHub Actions Workflow
The provided GitHub Actions workflow automates the deployment process for Terraform. It is triggered when you push code to the main branch or manually via the Actions tab.

Workflow File (.github/workflows/aws-deployment.yml)
yaml
Copy code
name: aws-deployment

on:
  push:
    branches: [ "main" ]

  workflow_dispatch:

jobs:
  Terraform_apply:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Terraform hashicorp setup
        uses: hashicorp/setup-terraform@v2

      - name: Configure AWS Credentials
        uses: aws-actions/configure-aws-credentials@v1
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1  # Replace with your AWS region

      - name: terraform init
        run: |
          cd Task2
          terraform init 

      - name: terraform plan
        run: |
          cd Task2
          terraform plan

      - name: terraform apply
        run: |
          cd Task2
          terraform apply -auto-approve
4. How to Use
Automatic Trigger
Whenever you push changes to the main branch, the workflow will be triggered automatically and execute the following Terraform commands:

terraform init: Initialize the Terraform working directory.
terraform plan: Generate and display the Terraform execution plan.
terraform apply -auto-approve: Apply the changes defined by your Terraform files automatically.
