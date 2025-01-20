# Let's build this step by step. 

# ### Part 1: Logging Function

# First, we'll create a `Write-ToLog` function that logs messages to a local file. Given your constraints, we'll keep it to 2 parameters: the type of message and the actual log message. The log file path will be predefined within the function.

# ```powershell

function Write-ToLog {
    param (
        [ValidateSet('info', 'error', 'critical')]
        [string]$MessageType,
        [string]$Message
    )

    $scriptName = $MyInvocation.MyCommand.Name
    $logFileName = "${scriptName}_$(Get-Date -Format 'yyyyMMdd').log"
    $logFilePath = Join-Path -Path $env:TEMP -ChildPath $logFileName

    $logMessage = "{0} [{1}] {2}" -f (Get-Date -Format 'yyyy-MM-dd HH:mm:ss'), $MessageType.ToUpper(), $Message
    Add-Content -Path $logFilePath -Value $logMessage
}

# # Example usage:
# Write-ToLog -MessageType 'info' -Message 'This is an informational message.'
# ```

### Part 2: Main Script with Functions

# Here’s an example of how to structure the main script with the described functions. Each function logs its actions using the `Write-ToLog` function.

# ```powershell
# Import the Write-ToLog function if it's defined in another script
# . .\Path\To\Write-ToLog.ps1

function Check-AzSession {
    if (-not (Get-AzContext)) {
        Write-ToLog -MessageType 'error' -Message 'No active Azure session found. Please login to Azure using Connect-AzAccount.'
        throw "Azure session must be active prior to running."
    }

    Write-ToLog -MessageType 'info' -Message 'Active Azure session verified.'
}

function Get-SentinelWorkspaces {
    $workspaces = Get-AzOperationalInsightsWorkspace
    $sentinelWorkspaces = @()

    foreach ($workspace in $workspaces) {
        # Check if Sentinel is enabled (example method)
        if ($workspace.Properties -and $workspace.Properties.features -contains 'Microsoft Sentinel') {
            $sentinelWorkspaces += $workspace
        }
    }

    Write-ToLog -MessageType 'info' -Message "Found $($sentinelWorkspaces.Count) Sentinel workspaces."
    return $sentinelWorkspaces
}

function Check-JsonFiles {
    param (
        [string]$Path
    )

    $jsonFiles = Get-ChildItem -Path $Path -Filter *.json

    if ($jsonFiles.Count -eq 0) {
        Write-ToLog -MessageType 'error' -Message 'No JSON files found in the provided path.'
        throw "No JSON files found in the provided path."
    }

    Write-ToLog -MessageType 'info' -Message "Found $($jsonFiles.Count) JSON files in the provided path."
    return $jsonFiles
}

function Deploy-ArmTemplates {
    param (
        [array]$SentinelWorkspaces,
        [array]$JsonFiles
    )

    foreach ($workspace in $SentinelWorkspaces) {
        foreach ($jsonFile in $JsonFiles) {
            $tempFileName = [System.IO.Path]::GetTempFileName()
            $tempFilePath = Join-Path -Path $env:TEMP -ChildPath $tempFileName

            $jsonContent = Get-Content -Path $jsonFile.FullName | ConvertFrom-Json
            $jsonContent.parameters.workspaceName.value = $workspace.Name

            $jsonContent | ConvertTo-Json | Set-Content -Path $tempFilePath

            $displayName = $jsonContent.resources.properties.displayname -replace '\W', ''

            Write-ToLog -MessageType 'info' -Message "Deploying ARM template for workspace: $($workspace.Name) with display name: $displayName"

            New-AzResourceGroupDeployment -ResourceGroupName $workspace.ResourceGroupName `
                -TemplateFile $jsonFile.FullName `
                -TemplateParameterFile $tempFilePath `
                -Name $displayName

            Remove-Item -Path $tempFilePath
        }
    }

    Write-ToLog -MessageType 'info' -Message "Deployment of ARM templates completed."
}

# Main script logic
try {
    Check-AzSession
    $sentinelWorkspaces = Get-SentinelWorkspaces
    $jsonFiles = Check-JsonFiles -Path 'Path\To\Json\Files'
    Deploy-ArmTemplates -SentinelWorkspaces $sentinelWorkspaces -JsonFiles $jsonFiles
} catch {
    Write-ToLog -MessageType 'error' -Message $_.Exception.Message
    throw $_
}
# ```

# This script ensures modularization, effective error handling, explanatory comments, and centralized logging. Adjust paths and parameters as necessary to fit your environment. If you need further customization or explanation, feel free to ask!