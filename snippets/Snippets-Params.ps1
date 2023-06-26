param (
    [Parameter(Mandatory = $true)]
    [string]$MandatoryArgument,

    [Parameter()]
    [string]$DefaultArgument = "Default Value",

    [Parameter()]
    [array]$ArrayArgument
)

Write-Host "Mandatory Argument: $MandatoryArgument"
Write-Host "Default Argument: $DefaultArgument"
Write-Host "Array Argument: $ArrayArgument"