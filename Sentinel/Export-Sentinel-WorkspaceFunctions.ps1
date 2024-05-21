param(
    [Parameter(Mandatory = $true)]$SubscriptionId,
    [Parameter(Mandatory = $true)]$ResourceGroup,
    [Parameter(Mandatory = $true)]$WorkspaceName,
    [Parameter()][string[]]$Categories
)

Connect-AzureAD

# Only export saved queries from these categories
# $Categories = ("sec", "usage", "proxy", "win", "o365")

# $ExportedSearches = (Get-AzOperationalInsightsSavedSearch -ResourceGroupName $ResourceGroup -WorkspaceName $WorkspaceName).Value.Properties | Where-Object { $Categories -contains $_.Category }
# Set the destination workspace

$SavedQueries = (Get-AzOperationalInsightsSavedSearch -ResourceGroupName $ResourceGroup -WorkspaceName $WorkspaceName).Value.Properties 

# $destSubscriptionId = Read-Host 



Set-AzContext -Subscription $SubscriptionId


# Import Saved Searches
foreach ($search in $ExportedSearches) {
    $id = $search.Category + "|" + $search.DisplayName
    New-AzOperationalInsightsSavedSearch -Force -ResourceGroupName $ResourceGroup -WorkspaceName $WorkspaceName -SavedSearchId $id -DisplayName $search.DisplayName -Category $search.Category -Query $search.Query -Version $search.Version
}
