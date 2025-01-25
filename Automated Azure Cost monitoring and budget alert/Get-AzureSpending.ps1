param (
    [Parameter(Mandatory = $true)]
    [string]$SubscriptionId
)

# Authenticate to Azure
Connect-AzAccount

# Set the subscription context
Set-AzContext -SubscriptionId $SubscriptionId

# Get the current month's start and end dates
$startDate = (Get-Date -Day 1).ToString("yyyy-MM-dd")
$endDate = (Get-Date).ToString("yyyy-MM-dd")

# Retrieve consumption usage details
$usageDetails = Get-AzConsumptionUsageDetail -StartDate $startDate -EndDate $endDate

# Calculate total cost
$totalCost = ($usageDetails | Measure-Object -Property PretaxCost -Sum).Sum

# Output the total cost
Write-Output "Total spending from $startDate to $endDate: $($totalCost.ToString('C2'))"
