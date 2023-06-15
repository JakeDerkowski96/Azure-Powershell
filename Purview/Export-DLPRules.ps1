Import-Module ExchangeOnlineManagement
Connect-IPPSSession -UserPrincipalName $superuser

$OutputDirectory = "dir"
$OutputFile = "file"
$OutputPath = "$OutputDirectory\$OutputFile"
$Rules = (Get-DlpComplianceRule | Format-List)
$Rules | Export-Csv -IncludeTypeInformation -Path $OutputPath