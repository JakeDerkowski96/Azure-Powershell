# Enable-AzSentienlRuleTemplates.ps1

$Tenant = @{
    Tenant         = "Tenantsec.com"
    TenantId       = ""
    Workspace      = "law-siem01"
    WorkspaceId    = ""
    ResourceGroup  = "rg-logs"
    Subscription   = "Tenant Trial Subscription"
    SubscriptionId = ""
    ResourceId     = "Sentinel ResourceId"
}

Import-Module Az.Accounts
Import-Module Az.SecurityInsights

Connect-AzAccount -TenantId $Tenant.TenantId

# $ruleTemplates = Get-AzSentinelAlertRuleTemplates -SubscriptionId $Tenant.SubscriptionId -WorkspaceName $Tenant.Workspace 

$existingRules = Get-AzSentinelAlertRule -SubscriptionId $Tenant.SubscriptionId -WorkspaceName $Tenant.Workspace -ResourceGroupName $Tenant.ResourceGroup

foreach ($rule in $existingRules) {
    if ($rule.Kind -eq "Scheduled") {
        Update-AzSentinelAlertRule -RuleId $rule.Id -SubscriptionId $Tenant.SubscriptionId -WorkspaceName $Tenant.Workspace -ResourceGroupName $Tenant.ResourceGroup -Scheduled -Enabled

    }
} 