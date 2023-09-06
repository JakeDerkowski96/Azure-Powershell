function Get-AzResourceId {
    param (
        [Parameter(Mandatory = $true)][string]$ResourceName,
        [Parameter(Mandatory = $true)][string]$ResourceType
    )
    Write-Verbose -Message "A Azure connection is required to access resources"

    Write-Verbose -Message "Searching for $($ResourceType) with the name $($ResourceName)"

    $ResourceId = (Get-AzResource -Name $ResourceName -ResourceType $ResourceType).Identity.PrincipalId

    return $ResourceId


    <#
.SYNOPSIS
Adds a file name extension to a supplied name.

.DESCRIPTION
Adds a file name extension to a supplied name.
Takes any strings for the file name or extension.

.PARAMETER ResourceName
The name given to the resource (i.e. the display name)

.PARAMETER ResourceType
The ResourceGraph type name
Example:  Microsoft.Logic/workflows == Logic Apps

.INPUTS
None. You cannot pipe objects to Add-Extension.

.OUTPUTS
System.String. Add-Extension returns a string with the extension
or file name.

.EXAMPLE
PS> extension -name "File"
File.txt

.LINK
Set-Item
#>    
}