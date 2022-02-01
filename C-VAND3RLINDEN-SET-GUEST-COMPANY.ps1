#This script can be used to autofill companyName attribute for known guest organizations based on guest domain in UserPrincipalName.

##Login Azure AD##
$Credentials = Get-AutomationPSCredential -Name 'C-VAND3RLINDEN-AUTOMATION'
# import AzureAD module
Import-Module AzureAD
# Connect to AzureAD
Connect-AzureAD -Credential $Credentials
##End Login Azure AD##

#Get Company: Contoso
$ContosoAdmins = Get-AzureADUser -All $true | Where-Object {$_.UserPrincipalName -like "*contoso.com*"}

#Set Company: Contoso
Foreach ($ContosoAdmin in $ContosoAdmins){
    Set-AzureADUser -ObjectId $ContosoAdmin.UserPrincipalname -CompanyName 'Contoso'
}

#Get Company: Fabrikam
$FabrikamAdmins = Get-AzureADUser -All $true | Where-Object {$_.UserPrincipalName -like "*fabrikam.com*"}

#Set Company: Fabrikam
Foreach ($FabrikamAdmin in $FabrikamAdmins){
    Set-AzureADUser -ObjectId $Fabrikam.UserPrincipalname -CompanyName 'Fabrikam'
}

#Rollback CompanyName: Remove-AzureADUserExtension -ObjectId $VARIABLEXX.UserPrincipalname -ExtensionName "CompanyName"
