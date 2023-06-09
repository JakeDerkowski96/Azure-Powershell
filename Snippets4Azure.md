# Snippets and tips for misc. Azure/Powershell

## Deploy Button

### Encode the Url

```powershell
$url = "Link to raw github file"
[uri]::EscapeDataString($url)
```

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/<encoded link here>)


## Deploy resources with Powershell


#### Get unique deployment name

```powershell
$today = Get-Date -Format "MM-dd-yyyy"
$suffix = Get-Random -Maximum 100
$deploySuffix = $today + "_$suffix"
$deploymentName = "<Playbook name>" + $deploySuffix
$remoteUrl = "https://raw.githubusercontent.com/Azure/Azure-Sentinel/master/Playbooks/Restrict-MDEAppExecution/alert-trigger/azuredeploy.json"
$localTemplate = 'Restrict-MDEAppExecution.parameters.json'
New-AzResourceGroupDeployment -Name $deploymentName `
    -ResourceGroupName $ResourceGroup `
    -TemplateUri $remoteUrl `
    -TemplateParameterFile $localTemplate
```


### Retrieve Azure tenant information




### Remote

### Local



# Powershell prompt user
```powershell
$title    = 'Confirm'
$question = 'Do you want to continue?'
$choices  = '&Yes', '&No'

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
    Write-Host 'Your choice is Yes.'
} else {
    Write-Host 'Your choice is No.'
}
```