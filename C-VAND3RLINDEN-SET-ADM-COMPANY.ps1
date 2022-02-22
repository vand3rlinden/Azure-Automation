#This script can be used to autofill an attribute based on displayname

#Connect Azure AD with Runbook:
. .\Login-AzureAD.ps1

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
