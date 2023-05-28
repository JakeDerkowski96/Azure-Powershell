param (
    [Parameter(Mandatory = $true)]
    [string]$SubscriptionName
)

# Login to Azure
Connect-AzAccount

# Get all resource groups
$resourceGroups = Get-AzResourceGroup

# Remove all resources in each resource group
foreach ($resourceGroup in $resourceGroups) {
    Remove-AzResourceGroup -Name $resourceGroup.ResourceGroupName -Force
}

# Cancel the subscription
Remove-AzSubscription -SubscriptionName $SubscriptionName -Force