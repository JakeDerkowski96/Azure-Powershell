# Deploy-ArmTemplateFolder.ps1

Param(
    $inFolder = "C:\Users\derko\OneDrive - derkcloudsec.com\Sentinel\Detections\json",
    $WorkspaceParameterFile = "C:\users\derko\onedrive - derkcloudsec.com\sentinelworkspace.parameters.json"
)

$DerkCloud = @{
    Tenant         = "derkcloudsec.com"
    TenantId       = "5cecf7e7-0aa4-49f4-8cab-2c7267f64ffa"
    Workspace      = "law-siem01"
    WorkspaceId    = "7d026a8f-1b8d-425e-af6c-2551eddb371e"
    ResourceGroup  = "rg-logs"
    Subscription   = "DerkCloud Trial Subscription"
    SubscriptionId = "8e970e2a-c002-4c7b-aee4-fe0538e8e16c"
    ResourceId     = "Sentinel ResourceId"
}

Connect-AzAccount -TenantId $DerkCloud.TenantId

$Templates = Get-ChildItem -Path $inFolder

foreach($template in $Templates){
    $deploymentName = "$($template.BaseName)_$($DerkCloud.Tenant)_$(Get-Random 1111)"

    if($deploymentName.Length -gt 83){
        $deploymentName = $deploymentName[0..64]
    }

    try {
        $deploymentInstance = New-AzResourceGroupDeployment `
        -Name $deploymentName `
        -TemplateFile $template `
        -ResourceGroupName $DerkCloud.ResourceGroup `
        -TemplateParameterFile $WorkspaceParameterFile

        Write-Host -ForegroundColor Green "$($deploymentName) was successful!"
        
    }
    catch {
        Write-Host -ForegroundColorRed "Deployment: $($deploymentName) failed"
    }





}