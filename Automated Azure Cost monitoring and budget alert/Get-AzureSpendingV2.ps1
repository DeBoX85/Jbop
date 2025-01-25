<#
.SYNOPSIS
    Retrieves and displays the total Azure spending for a specified subscription within a given date range.

.DESCRIPTION
    This script authenticates to Azure, sets the specified subscription context, and retrieves consumption usage details
    for the provided date range. It calculates the total pretax cost and outputs the spending information.

.PARAMETER SubscriptionId
    The ID of the Azure subscription to analyze.

.PARAMETER StartDate
    The start date for the usage data retrieval in 'yyyy-MM-dd' format. Defaults to the first day of the current month.

.PARAMETER EndDate
    The end date for the usage data retrieval in 'yyyy-MM-dd' format. Defaults to the current date.

.EXAMPLE
    .\Get-AzureSpending.ps1 -SubscriptionId 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'

.NOTES
    Ensure that the Az PowerShell module is installed and updated. Run 'Update-Module -Name Az' to update.
#>

param (
    [Parameter(Mandatory = $true)]
    [string]$SubscriptionId,

    [Parameter(Mandatory = $false)]
    [string]$StartDate = (Get-Date -Day 1).ToString("yyyy-MM-dd"),

    [Parameter(Mandatory = $false)]
    [string]$EndDate = (Get-Date).ToString("yyyy-MM-dd")
)

function Authenticate-Azure {
    try {
        Connect-AzAccount -ErrorAction Stop
        Write-Host "Successfully authenticated to Azure." -ForegroundColor Green
    } catch {
        Write-Error "Failed to authenticate to Azure. $_"
        exit
    }
}

function Set-SubscriptionContext {
    param (
        [Parameter(Mandatory = $true)]
        [string]$SubId
    )
    try {
        Set-AzContext -SubscriptionId $SubId -ErrorAction Stop
        Write-Host "Context set for Subscription ID: $SubId" -ForegroundColor Green
    } catch {
        Write-Error "Failed to set subscription context. $_"
        exit
    }
}

function Get-UsageDetails {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Start,
        [Parameter(Mandatory = $true)]
        [string]$End
    )
    try {
        $usage = Get-AzConsumptionUsageDetail -StartDate $Start -EndDate $End -ErrorAction Stop
        Write-Host "Retrieved usage details from $Start to $End." -ForegroundColor Green
        return $usage
    } catch {
        Write-Error "Failed to retrieve consumption data. $_"
        exit
    }
}

function Calculate-TotalCost {
    param (
        [Parameter(Mandatory = $true)]
        $UsageData
    )
    $total = ($UsageData | Measure-Object -Property PretaxCost -Sum).Sum
    return $total
}

# Main Script Execution
Authenticate-Azure
Set-SubscriptionContext -SubId $SubscriptionId
$usageDetails = Get-UsageDetails -Start $StartDate -End $EndDate
$totalCost = Calculate-TotalCost -UsageData $usageDetails

if ($totalCost -eq $null) {
    Write-Host "No consumption data found for the specified date range." -ForegroundColor Yellow
} else {
    Write-Host "Total spending for Subscription ID $SubscriptionId from $StartDate to $EndDate: $($totalCost.ToString('C2'))" -ForegroundColor Cyan
}
