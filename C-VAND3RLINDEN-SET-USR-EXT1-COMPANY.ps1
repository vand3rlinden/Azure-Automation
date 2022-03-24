<#
This script can be used to autofill an attribute based on an Exchange ExtensionAttributes, for this example we used EXT1. 
#>

#Connect EXO
. .\Login-EXO.ps1

#Connect Azure AD
. .\Login-AzureAD.ps1

#Get all mailboxes on filter CustomAttribute1
$Recipients = Get-Mailbox -resultSize unlimited | Where-Object {($_.CustomAttribute1 -like 'Active Internal') -or ($_.CustomAttribute1 -like 'External')} | Select-Object UserPrincipalname

#Set AAD user companyName
Foreach ($Recipient in $Recipients){
    Set-AzureADUser -ObjectId $Recipient.UserPrincipalname -CompanyName 'VAND3RLINDEN'
}

#To prevent the script from failing with a maximum of 3 allowed connections to EXO.
Get-PSSession | Remove-PSSession

#Rollback CompanyName: Remove-AzureADUserExtension -ObjectId $Recipient.UserPrincipalname -ExtensionName "CompanyName"
#Export query first: Get-Mailbox -resultSize unlimited | Where-Object {($_.CustomAttribute1 -like 'Active Internal') -or ($_.CustomAttribute1 -like 'External')} | Select-Object UserPrincipalname | Export-CSV -Path "C:\Temp\outcome.csv" -NoTypeInformation
