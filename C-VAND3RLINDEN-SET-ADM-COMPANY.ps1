#This script can be used to autofill an attribute based on displayname. For example, your internal admin accounts.

#Connect Azure AD
. .\Login-AzureAD.ps1

### CompanyName: Your CompanyName
#Get the users
$Members = Get-AzureADUser -All $true | Where-Object {$_.DisplayName -like "*(Admin Account)"}

#Set CompanyName
ForEach ($Member in $Members){
    Set-AzureADUser -ObjectId $Member.UserPrincipalname -CompanyName 'Your CompanyName' #Set
    #Get-AzureADUser -ObjectId $Member.UserPrincipalname | Select-Object UserPrincipalname #Test
    #Remove-AzureADUserExtension -ObjectId -ObjectId $Member.UserPrincipalname -ExtensionName "CompanyName" #Rollback
}
