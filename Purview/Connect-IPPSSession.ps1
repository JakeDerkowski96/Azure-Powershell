Function Connect-Exchange {
    $ModuleName = "ExchangeOnlineManagement"
    Import-Module $ModuleName
    Write-Verbose -Message "Connecting to $($ModuleName) with currentuser"
    $user = "$($env:username)@$($USERDNSDOMAIN)"
    Connect-IPPSSession -UserPrincipalName $user | Out-Null
}