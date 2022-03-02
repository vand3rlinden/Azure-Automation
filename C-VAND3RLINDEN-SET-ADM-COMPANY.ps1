#This script can be used to autofill an attribute based on displayname, for example your external admin accounts.

#Connect Azure AD with Runbook:
. .\Login-AzureAD.ps1

### CompanyName: Contoso
#Get the users
$Members = Get-AzureADUser -All $true | Where-Object {$_.DisplayName -like "*(Contoso Admin)"}

#Set CompanyName
ForEach ($Member in $Members){
Set-AzureADUser -ObjectId $Member.UserPrincipalname -CompanyName 'Contoso'
}

### CompanyName: Fabrikam
#Get the users
$Members = Get-AzureADUser -All $true | Where-Object {$_.DisplayName -like "*(Fabrikam Admin)"}

#Set CompanyName
ForEach ($Member in $Members){
Set-AzureADUser -ObjectId $Member.UserPrincipalname -CompanyName 'Fabrikam'
}

#Rollback: Remove-AzureADUserExtension -ObjectId -ObjectId $Member.UserPrincipalname -ExtensionName "CompanyName"
