# look up the parameters for connect azure ad
function Connect-2AAD(){
    Write-Verbose "Connecting User"
    $user = "$($env:USERNAME)@$($env:USERDNSDOMAIN)"
    Connect-AzureAD -AccountId $User
}

# look up the parameters for connect azure ad
function AzLogin() {
    Write-Verbose "Connecting User"
    $user = "$($env:USERNAME)@$($env:USERDNSDOMAIN)"
    Login-AzAccount -AccountId $User
}