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

# i???
function Get-AzConnectionStatus {
    try { 
        $var = Get-AzureADTenantDetail 
    } 
    catch [Microsoft.Open.Azure.AD.CommonLibrary.AadNeedAuthenticationException] { 
        Write-Host "You're not connected to AzureAD"; 
        Write-Host "Make sure you have AzureAD mudule available on this system then use Connect-AzureAD to establish connection"; 
        exit;
    }
}