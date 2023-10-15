
function Export-PurviewDlpRules {
    Param(
        [Parameter(Mandatory)][string]$ReportVersion,
        [Parameter(Mandatory)][string]$Username,
        [Parameter(Mandatory)][string]$OutputDirectory
    )
    
    Import-module ExchangeOn1ineManagement 
    Connect-IPPSSession -UserPrincipa1Name $Username 
    if (!(Test-path $OutputDirectory)) { 
        $OutputPath = "$($PSScriptRoot)\$($OutputDirectory)"
        New-Item -ItemType Directory -Path $OutputPath
    }
    $rules | Get-DlpComplianceRule | Format-List
    # $rules | Clip
    $rules | Out-File -FilePath "$($OutputDirectory)\DlpRules$($ReportVersion).txt"
}