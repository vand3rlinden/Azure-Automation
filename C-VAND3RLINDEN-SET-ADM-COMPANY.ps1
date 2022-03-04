<#
This script can be used to autofill an attribute based on displayname. For example, your internal admin accounts.
Command in: Set-AzureADUser and command out: Get-AzureADUser with the $Export variable to check the output your are changing
Command in: Set-AzureADUser and command out: Remove-AzureADUserExtension to roll back the script
#>

#Connect Azure AD
. .\Login-AzureAD.ps1

### CompanyName: Your CompanyName
#Get the users
$Members = Get-AzureADUser -All $true | Where-Object {$_.DisplayName -like "*(Admin Account)"}

#Set CompanyName
#$Export = foreach ($Member in $Members){ #Comment out for: Test
ForEach ($Member in $Members){
    Set-AzureADUser -ObjectId $Member.UserPrincipalname -CompanyName 'Your CompanyName' #Comment out for: Set
    #Get-AzureADUser -ObjectId $Member.UserPrincipalname | Select-Object UserPrincipalname #Comment out for: Test
    #Remove-AzureADUserExtension -ObjectId -ObjectId $Member.UserPrincipalname -ExtensionName "CompanyName" #Comment out for: Rollback
}
#$Export | Export-CSV -Path "C:\Temp\file3.csv" -NoTypeInformation #Comment out for: Test
