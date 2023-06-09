# Create unique deployment name
[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]
    $ResourceGroup
)
    
Connect-AzureAD

Get-AzResourceGroup -Name $ResourceGroup -ErrorVariable notPresent -ErrorAction SilentlyContinue

if ($notPresent) {
    Write-Host "This resource group does not exist. To create new resource group"
    
    $Location = Read-Host "Enter the location:"
    
    New-AzResourceGroup -Name $ResourceGroup `
        -Location $Location `
        -Verbose
}


# create a unique name to name the deployyment
# add suffix to the name of each AzResource
$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"


# set up easy navigation to the playbook's respective directory
$cwd = $(pwd)
$testHome = Split-Path $cwd

# FOR THIS TO WORK YOU MUST RUN THIS SCRIPT FROM THE DIRECTORY IT IS LOCATED IN!!!
# move to the playbook directory
function Goto-PlaybookPath {
    param (
        [Parameter(Mandatory=$true)]
        [string]
        $testHome,
        $PlaybookName       
    )
    pwd
    Write-Host $testHome
    cd $testHome
    # pwd
    cd "Playbooks\$($PlaybookName)"
    # pwd
}



# $Name = "AS-Azure-AD-Disable-User"
# Goto-PlaybookPath $testHome $Name
# $deploymentName = $Name + $deploySuffix
# $TemplateFile = "azuredeploy.json"
# $TemplateParametersFile = "azuredeploy.parameters.json"
# New-AzResourceGroupDeployment -Name $deploymentName `
#     -ResourceGroupName $ResourceGroup `
#     -TemplateUri $remoteUrl `
#     -TemplateParameterFile $localTemplate `
#     -Verbose
# # -----------------------------------------------------

# $Name = "AS-Compromised-Machine-Tagging"
# Goto-PlaybookPath $testHome $Name
# $deploymentName = $Name + $deploySuffix
# $TemplateFile = "azuredeploy.json"
# $TemplateParametersFile = "azuredeploy.parameters.json"
# New-AzResourceGroupDeployment -Name $deploymentName `
#     -ResourceGroupName $ResourceGroup `
#     -TemplateUri $remoteUrl `
#     -TemplateParameterFile $localTemplate `
#     -Verbose

# # -----------------------------------------------------

# $Name = "AS-IP-Blocklist"
# Goto-PlaybookPath $testHome $Name
# $deploymentName = $Name + $deploySuffix
# $TemplateFile = "azuredeploy.json"
# $TemplateParametersFile = "azuredeploy.parameters.json"
# New-AzResourceGroupDeployment -Name $deploymentName `
#     -ResourceGroupName $ResourceGroup `
#     -TemplateUri $remoteUrl `
#     -TemplateParameterFile $localTemplate `
#     -Verbose


# # -----------------------------------------------------

# $Name = "Block-OnPremADUser"
# Goto-PlaybookPath $testHome $Name
# $deploymentName = $Name + $deploySuffix
# $TemplateFile = "azuredeploy.json"
# $TemplateParametersFile = "azuredeploy.parameters.json"
# New-AzResourceGroupDeployment -Name $deploymentName `
#     -ResourceGroupName $ResourceGroup `
#     -TemplateUri $remoteUrl `
#     -TemplateParameterFile $localTemplate `
#     -Verbose


# # -----------------------------------------------------

# $Name = "Isolate-MDE-Machine-entityTrigger"
# Goto-PlaybookPath $testHome $Name
# $deploymentName = $Name + $deploySuffix
# $TemplateFile = "azuredeploy.json"
# $TemplateParametersFile = "azuredeploy.parameters.json"
# New-AzResourceGroupDeployment -Name $deploymentName `
#     -ResourceGroupName $ResourceGroup `
#     -TemplateUri $remoteUrl `
#     -TemplateParameterFile $localTemplate `
#     -Verbose


# # -----------------------------------------------------

# $Name = "Revoke-AADSignIn-Session-entityTrigger"
# Goto-PlaybookPath $testHome $Name
# $deploymentName = $Name + $deploySuffix
# $TemplateFile = "azuredeploy.json"
# $TemplateParametersFile = "azuredeploy.parameters.json"
# New-AzResourceGroupDeployment -Name $deploymentName `
#     -ResourceGroupName $ResourceGroup `
#     -TemplateUri $remoteUrl `
#     -TemplateParameterFile $localTemplate `
#     -Verbose


# # -----------------------------------------------------

# $Name = "Save-NamedLocations"
# Goto-PlaybookPath $testHome $Name
# $deploymentName = $Name + $deploySuffix
# $TemplateFile = "azuredeploy.json"
# $TemplateParametersFile = "azuredeploy.parameters.json"
# New-AzResourceGroupDeployment -Name $deploymentName `
#     -ResourceGroupName $ResourceGroup `
#     -TemplateUri $remoteUrl `
#     -TemplateParameterFile $localTemplate `
#     -Verbose


# # -----------------------------------------------------

# $Name = "Send-ConnectorHealthStatus"
# Goto-PlaybookPath $testHome $Name
# $deploymentName = $Name + $deploySuffix
# $TemplateFile = "azuredeploy.json"
# $TemplateParametersFile = "azuredeploy.parameters.json"
# New-AzResourceGroupDeployment -Name $deploymentName `
#     -ResourceGroupName $ResourceGroup `
#     -TemplateUri $remoteUrl `
#     -TemplateParameterFile $localTemplate `
#     -Verbose


# # -----------------------------------------------------

# $Name = "Send-email-with-formatted-incident-report"
# Goto-PlaybookPath $testHome $Name
# $deploymentName = $Name + $deploySuffix
# $TemplateFile = "azuredeploy.json"
# $TemplateParametersFile = "azuredeploy.parameters.json"
# New-AzResourceGroupDeployment -Name $deploymentName `
#     -ResourceGroupName $ResourceGroup `
#     -TemplateUri $remoteUrl `
#     -TemplateParameterFile $localTemplate `
#     -Verbose


# # -----------------------------------------------------

# $Name = "Start-MDEAutomatedInvestigation"
# Goto-PlaybookPath $testHome "$($Name)\alert-trigger"
# $deploymentName = $Name + $deploySuffix
# $TemplateFile = "azuredeploy.json"
# $TemplateParametersFile = "azuredeploy.parameters.json"
# New-AzResourceGroupDeployment -Name $deploymentName `
#     -ResourceGroupName $ResourceGroup `
#     -TemplateUri $remoteUrl `
#     -TemplateParameterFile $localTemplate `
#     -Verbose


# # -----------------------------------------------------

# $Name = "Unisolate-MDE-Machine-entityTrigger"
# Goto-PlaybookPath $testHome $Name
# $deploymentName = $Name + $deploySuffix
# $TemplateFile = "azuredeploy.json"
# $TemplateParametersFile = "azuredeploy.parameters.json"
# New-AzResourceGroupDeployment -Name $deploymentName `
#     -ResourceGroupName $ResourceGroup `
#     -TemplateUri $remoteUrl `
#     -TemplateParameterFile $localTemplate `
#     -Verbose


# # -----------------------------------------------------
