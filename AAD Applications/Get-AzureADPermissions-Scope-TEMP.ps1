Install-Module AzureAD
Import-Module AzureAD
Connect-AzureAD

# Get-AzureADServicePrincipal cmdlet returns all the service principal objects, we can filter the result by using the Tags property to list only integrated applications
$tag = "security"
Get-AzureADServicePrincipal -All:$true | ? {$_.Tags -eq $tag}

# The below command returns limited fields alone.
Get-AzureADServicePrincipal -All:$true |?{$_.Tags -eq $tag}| Select-Object ObjectId,AppDisplayName,AppId,PublisherName

# Get all Delegated Permissions granted to an application

# We can use the Get-AzureADServicePrincipalOAuth2PermissionGrant cmdlet to fetch OAuth delegated permissions which have been granted to the application either by end-user (User Consent) or Admin user (Admin Consent)

#$ServicePrincipalId = (Get-AzureADServicePrincipal -Top 1).ObjectId
#Provide ObjectId of your service principal object
$ServicePrincipalId = "5614c8c4-22bb-45c7-9be3-47491152703d"
Get-AzureADServicePrincipalOAuth2PermissionGrant -ObjectId $ServicePrincipalId | FL

# Get all Application Permissions granted to an application
$AppPermissions =@()
$ResourceAppHash = @{}
#Provide ObjectId of your service principal object
$ServicePrincipalId = ""
$AppRoleAssignments = Get-AzureADServiceAppRoleAssignedTo -ObjectId $ServicePrincipalId
$AppRoleAssignments | ForEach-Object {
    $RoleAssignment = $_
    $AppRoles = {}
    If ($ResourceAppHash.ContainsKey($RoleAssignment.ResourceId)) {
        $AppRoles = $ResourceAppHash[$RoleAssignment.ResourceId]
        } Else {
            $AppRoles = (Get-AzureADServicePrincipal -ObjectId 
            $RoleAssignment.ResourceId).AppRoles
            #Store AppRoles to re-use.
            #Probably all role assignments use the same resource (Ex: Microsoft Graph).
            $ResourceAppHash[$RoleAssignment.ResourceId] = $AppRoles
        }
        $AppliedRole = $AppRoles | Where-Object {$_.Id -eq $RoleAssignment.Id
        }  
$AppPermissions += New-Object PSObject -property @{
    DisplayName = $AppliedRole.DisplayName
    Roles = $AppliedRole.Value
    Description = $AppliedRole.Description
    IsEnabled = $AppliedRole.IsEnabled
    ResourceName = $RoleAssignment.ResourceDisplayName
    }
}
$AppPermissions | FL

# Get users who are associated with the application

#Provide ObjectId of your service principal object
$ServicePrincipalId = ""
Get-AzureADServiceAppRoleAssignment -ObjectId $ServicePrincipalId | Select ResourceDisplayName,PrincipalDisplayName
 
