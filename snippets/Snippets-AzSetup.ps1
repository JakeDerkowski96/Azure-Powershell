function AzLogin {
    Write-Verbose "Connecting current user"
    $User = "$($env:username)@$($env:USERDNSDOMAIN)"
    # Connect-AzureAD -AccountId $User
    Connect-AzAccount -AccountId $User
}

# -----------------------------------------------------------

# Get resource/subscription/other Ids // accessing an objects attributes

# get current subscription
$subscription = Get-AzContext
$subscriptionId = (get-AzContext).Subscription.Id
$subscriptionName = (Get-AzSubscription -SubscriptionId $subscriptionId).Name

# sekect subscription (GUI)
$subscription = Get-AzSubscription | Out-GridView -Title "Select the subscription to save to variable" -PassThru 
Select-AzSubscription -SubscriptionName $subscription.Name

$resourceGroup = Get-AzResourceGroup | Out-GridView -Title "Select Resource Group to save to variable" -PassThru 

# -----------------------------------------------------------
