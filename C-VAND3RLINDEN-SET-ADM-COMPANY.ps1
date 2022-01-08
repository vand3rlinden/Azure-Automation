#This script can be used to autofill an attribute based on displayname

##Login Azure AD##
$Credentials = Get-AutomationPSCredential -Name 'C-VAND3RLINDEN-AUTOMATION'
# import AzureAD module
Import-Module AzureAD
# Connect to AzureAD
Connect-AzureAD -Credential $Credentials
##End Login Azure AD##

###CompanyName: VAND3RLINDEN###
#Get All Azure AD Users that have a DisplayName like
$Members = Get-AzureADUser -All $true | Where-Object {$_.DisplayName -like "*(VAND3RLINDEN ADMIN)"}

#Set CompanyName
ForEach ($Member in $Members){
Set-AzureADUser -ObjectId $Member.UserPrincipalname -CompanyName 'VAND3RLINDEN'
}

###CompanyName: LIND3N###
#Get All Azure AD Users that have a DisplayName like
$Members = Get-AzureADUser -All $true | Where-Object {$_.DisplayName -like "*(LIND3N ADMIN)"}

#Set CompanyName
ForEach ($Member in $Members){
Set-AzureADUser -ObjectId $Member.UserPrincipalname -CompanyName 'LIND3N'
}

#Rollback: Remove-AzureADUserExtension -ObjectId -ObjectId $Member.UserPrincipalname -ExtensionName "CompanyName"
