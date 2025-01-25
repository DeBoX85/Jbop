# Azure Cost Monitoring and Budget Alerts

## Description
This project automates the creation of a budget in Azure Cost Management and provides a PowerShell script to monitor current spending. It helps organizations maintain control over their Azure expenditures by setting budget thresholds and receiving alerts when spending exceeds defined limits.

## Features
- ARM template to create a budget with specified thresholds.
- PowerShell script to retrieve and report current spending.
- Alerts configured to notify stakeholders when spending exceeds budget thresholds.
- Supports proactive cost management and aligns with FinOps best practices.

## Prerequisites
1. An active Azure subscription.
2. Azure CLI or Azure PowerShell installed locally.
3. Appropriate permissions to create budgets and access cost data in the Azure subscription.

## Deployment Steps

### 1. Set Up Budget with ARM Template
1. Clone this repository.
2. Navigate to the project folder.
3. Customize the `budget.parameters.json` file with your desired budget settings.
4. Deploy the ARM template using the Azure CLI or PowerShell:
   ```bash
   az deployment group create --resource-group <ResourceGroupName> --template-file budget.json --parameters budget.parameters.json
