function Check-AzConnection {
    if ($null -eq $(Get-AzContext)) {
        try {
            $Conn = Connect-AzAccount
            if ($null -ne $Conn) {
                Write-Host -ForegroundColor "Successful authenticated with $($conn.Context.Account.Id)"                
            }
            else {
                Write-Host -ForegroundColor Red "Failed to authenticate to Azure"
            }
        }
        catch {
            Write-Host -ForegroundColor Red "Failed to authenticate to Azure"
        }        
    }
    else {
        Write-Host -ForegroundColor Green "A connection has already been established with $($conn.Context.Account.Type) to $($conn.Context.Account.Id)"
    }
}

function Install-Module-If-Needed {
    param([string]$ModuleName)

    if (Get-Module -ListAvailable -Name $ModuleName) {
        Write-Host "Module '$($ModuleName)' already exists, continue..." -ForegroundColor Green
    }
    else {
        Write-Host "Module '$($ModuleName)' does not exist, installing..." -ForegroundColor Yellow
        Install-Module $ModuleName -Force -AllowClobber -ErrorAction Stop
        Write-Host "Module '$($ModuleName)' installed." -ForegroundColor Green
    }
}

Install-Module-If-Needed -ModuleName "Az.Accounts"

# Connect if not connected
Check-AzConnection

$

#! Get Az Access Token
$token = Get-AzAccessToken #This will default to Azure Resource Manager endpoint
$authHeader = @{
    'Content-Type'  = 'application/json'
    'Authorization' = 'Bearer ' + $token.Token
}

$workspaceName = "law-siem01"
$subscriptionId = "8e970e2a-c002-4c7b-aee4-fe0538e8e16c"
$resourceGroupName = "rg-logs"

$WorkspaceParameters = @{
    subscriptionId    = $subscriptionId
    workspaceName     = $workspaceName
    resourceGroupName = $resourceGroupName
}






# Get Content Product Packages
$contentURI = "https://management.azure.com/subscriptions/$subscriptionid/resourceGroups/$resourceGroupName/providers/Microsoft.OperationalInsights/workspaces/$workspaceName/providers/Microsoft.SecurityInsights/contentProductPackages?api-version=2023-09-01-preview"

$Context = Get-AzContext 