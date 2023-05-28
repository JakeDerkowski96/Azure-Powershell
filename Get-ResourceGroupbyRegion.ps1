
$ResultResources = @()
$Subscriptions = Get-AzSubscription
foreach ($Subscription in $Subscriptions) {
    Set-AzContext -Subscription $Subscription.Id
    $ResourceGroups = Get-AzResourceGroup
    foreach ($ResourceGroup in $ResourceGroups) {
        $Resources = Get-AzResource -ResourceGroupName $ResourceGroup.ResourceGroupName
        foreach ($Resource in $Resources) {
            if ($Resource.Location -eq "centralus") {
                $ResultResources += $Resource
            }
        }
    }
}
$ResultResources | Group-Object -Property ResourceType | Sort-Object -Property {$_.ResourceId}