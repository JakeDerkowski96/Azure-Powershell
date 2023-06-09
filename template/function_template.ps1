function Function-Name (params) {
    <#
.SYNOPSIS
    Use NtQuerySystemInformation::SystemProcessInformation to get a detailed
    list of processes and process properties. On close inspection you will
    find that many process monitors such as Sysinternals Process Explorer or
    Process Hacker use this information class (in addition to
    SystemPerformanceInformation, SystemProcessorPerformanceInformation and
    SystemProcessorCycleTimeInformation).
.DESCRIPTION
    Author: 
    License: 
    Required Dependencies: 
    Optional Dependencies: 
.PARAMETER P1
    P1
.PARAMETER P2
    P2
.EXAMPLE
    # Return full process listing
    C:\PS> Get-SystemProcessInformation   
#>


    #-----------------------------------------------------------------------------------------------------------------------
    Function Show-ExampleFunctionTemplate {
        #-------------------------------------------------------------------------------
        <#
	.SYNOPSIS
	Short explanation of what this function does.
	
	.DESCRIPTION
	Longer, more descriptive definition of what this function's purpose is, what it was designed to do.
	
	.NOTES
	Generally, the 3 help topics .SYNOPSIS, .DESCRIPTION, and .NOTES are the bare minimum required for Comment-Based Help to work, but this is inconsistent across PowerShell versions.
	
	.LINK
	help about_Comment_Based_Help
	http://techgenix.com/powershell-functions-common-parameters/
	help about_Requires
	help about_CommonParameters
	#>
	
        #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
        #Requires -Modules PSLogging
        <#
	# "#Requires" - You can use a #Requires statement to prevent a script from running without specified modules or snap-ins and a specified version of PowerShell. For more information, see about_Requires.
	# e.g. "#Requires -Version 6" "#Requires -RunAsAdministrator"
	#>
	
        #- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
	
        #http://techgenix.com/powershell-functions-common-parameters/
        # To enable common parameters in functions (-Verbose, -Debug, etc.) the following 2 lines must be present:
        #[CmdletBinding()]
        #Param()
	
        [CmdletBinding()]
        #[CmdletBinding(SupportsShouldProcess=$true)]
	
        Param (
            #Script parameters go here
            [Parameter(Mandatory = $false, Position = 0,
                ValueFromPipeline = $true)]
            [string]$Path,
		
            [switch]$Force = $false
        )
