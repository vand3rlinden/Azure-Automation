<#
This script can be used to autofill companyName attribute for known guest organizations based on guest domain in UserPrincipalName.
Guest users have an UPN like: name_domain.com#EXT#@domain.onmicrosoft.com
#>

#Connect Azure AD with Runbook:
. .\Login-AzureAD.ps1

### CompanyName: Contoso
#Get the users
$Members = Get-AzureADUser -All $true | Where-Object {$_.UserPrincipalName -like "*contoso.com*"}

#Set Company
Foreach ($Member in $Members){
    Set-AzureADUser -ObjectId $Member.UserPrincipalname -CompanyName 'Contoso'
}

### CompanyName: Fabrikam
#Get the users
$Members = Get-AzureADUser -All $true | Where-Object {$_.UserPrincipalName -like "*fabrikam.com*"}

#Set Company
Foreach ($Member in $Members){
    Set-AzureADUser -ObjectId $Member.UserPrincipalname -CompanyName 'Fabrikam'
}

#Rollback CompanyName: Remove-AzureADUserExtension -ObjectId $VARIABLEXX.UserPrincipalname -ExtensionName "CompanyName"
