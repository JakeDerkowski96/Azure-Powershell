param(
    [Parameter(Mandatory = $true)]$ResourceGroup
)

# REPLACE WITH AZUREAD CONNECTION TEST FUNCTION
Connect-AzureAD

# REPLACE WITH CHECK-AZRG FUNCTION
# check is RG exists, create one with the provided name if False
Get-AzResourceGroup -Name $ResourceGroup -ErrorVariable notPresent -ErrorAction SilentlyContinue


if ($notPresent) {
    Write-Host "This resource group does not exist. To create new resource group"
    
    $Location = Read-Host "Enter the location:"
    
    New-AzResourceGroup -Name $ResourceGroup `
        -Location $Location `
        -Verbose
}
# END OF CHECK-AZRG FUNCTION

# DEPLOY LOCAL OR REMOTE TEMPLATE FUNCTION HERE



# Create unique deployment name
# function for this? run once at beginning of script then use for all names? idk?
$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"
# end idk


# for github arm tempaltes
$OriginalName = ""
$trigger = "" #or
$ResourceType = ""
# $trigger = "incident-trigger"
$deploymentName = $Name + $deploySuffix
$ResourceName = Get-ResourceName -ResourceName $Name -ResourceType $ResourceType

$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/$Name/$trigger/azuredeploy.json"
$TemplatePath = ""

$CustomParameters = "Parameters/$Name.json"
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    # -ParameterFile $TemplatePath
    -TemplateParameterFile $CustomParameters `
    -Verbose
