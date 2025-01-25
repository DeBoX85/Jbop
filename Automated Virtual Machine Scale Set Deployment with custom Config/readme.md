# Automated VM Scale Set Deployment

## Description
This project provides an ARM template to deploy a Virtual Machine Scale Set (VMSS) in Azure, along with a PowerShell script to perform custom configurations on each VM instance. The VMSS is configured to scale automatically based on CPU usage, ensuring optimal performance and cost-efficiency.

## Features
- Deploys a VM Scale Set with a specified number of instances.
- Configures auto-scaling based on CPU utilization.
- Applies custom configurations to each VM instance using a PowerShell script.
- Utilizes Azure best practices for resource deployment and management.

## Prerequisites
1. An active Azure subscription.
2. Azure CLI or Azure PowerShell installed locally.
3. Familiarity with ARM templates and PowerShell scripting.

## Deployment Steps
1. Clone this repository.
2. Navigate to the project folder.
3. Customize the `azuredeploy.parameters.json` file with your desired settings.
4. Deploy the ARM template using the Azure CLI or PowerShell:
   ```bash
   az deployment group create --resource-group <ResourceGroupName> --template-file azuredeploy.json --parameters azuredeploy.parameters.json
