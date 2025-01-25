param (
    [Parameter(Mandatory = $true)]
    [string]$SubscriptionId,

    [Parameter(Mandatory = $false)]
    [string]$StartDate = (Get-Date -Day 1).ToString("yyyy-MM-dd"),

    [Parameter(Mandatory = $false)]
    [string]$EndDate = (Get-Date).ToString("yyyy-MM-dd")
)

# Authenticate to Azure
Write-Host "Authenticating to Azure..." -ForegroundColor Green
try {
    Connect-AzAccount -ErrorAction Stop
} catch {
    Write-Error "Failed to authenticate to Azure. Ensure you are logged in."
    exit
}

# Set the subscription context
Write-Host "Setting context for Subscription ID: $SubscriptionId..." -ForegroundColor Green
try {
    Set-AzContext -SubscriptionId $SubscriptionId -ErrorAction Stop
} catch {
    Write-Error "Failed to set subscription context. Check the Subscription ID."
    exit
}

# Retrieve consumption usage details
Write-Host "Retrieving consumption usage details from $StartDate to $EndDate..." -ForegroundColor Green
try {
    $usageDetails = Get-AzConsumptionUsageDetail -StartDate $StartDate -EndDate $EndDate -ErrorAction Stop
} catch {
    Write-Error "Failed to retrieve consumption data. Ensure the Subscription ID is valid and has usage details."
    exit
}

# Calculate total cost
$totalCost = ($usageDetails | Measure-Object -Property PretaxCost -Sum).Sum

# Output the total cost
if ($totalCost -eq $null) {
    Write-Host "No consumption data found for the specified date range." -ForegroundColor Yellow
} else {
    Write-Output "Total spending for Subscription ID $SubscriptionId from $StartDate to $EndDate: $($totalCost.ToString('C2'))"
}
