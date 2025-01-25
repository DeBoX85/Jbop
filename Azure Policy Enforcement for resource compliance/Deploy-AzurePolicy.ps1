param (
    [Parameter(Mandatory = $true)]
    [string]$SubscriptionId
)

# Login to Azure
Write-Host "Authenticating with Azure..."
az login

# Set the subscription
Write-Host "Setting the subscription to $SubscriptionId..."
az account set --subscription $SubscriptionId

# Deploy the ARM template
Write-Host "Deploying Azure Policy..."
$templateFile = "azurepolicy.json"
$parameterFile = "azurepolicy.parameters.json"

az deployment sub create --location eastus --template-file $templateFile --parameters @$parameterFile

Write-Host "Azure Policy deployment completed successfully!"
