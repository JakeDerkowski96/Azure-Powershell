$tenantId = ""
$clientId = ""
$secret = 


Connect-AzAccount
$baseUri = "https://management.azure.com"
$token = (Get-AzAccessToken -ResourceUrl $baseUri).Token
