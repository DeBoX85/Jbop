# Azure Policy Enforcement for Resource Compliance

## Description
This project automates the creation and deployment of an Azure Policy that restricts the deployment of resources to specified Azure regions. The project is suitable for enforcing organizational compliance and ensures resources are only created in approved regions.

## Features
- ARM template to define an Azure Policy for allowed regions.
- PowerShell script to deploy the policy at the subscription level.
- Ensures compliance with organizational policies.

## Prerequisites
1. An active Azure subscription.
2. Azure CLI or Azure PowerShell installed locally.
3. Contributor or Owner role in the Azure subscription.

## Deployment Steps
1. Clone this repository.
2. Customize the `azurepolicy.parameters.json` file to specify the allowed regions.
3. Deploy the policy using the PowerShell script:
   ```powershell
   .\Deploy-AzurePolicy.ps1 -SubscriptionId <YourSubscriptionId>
