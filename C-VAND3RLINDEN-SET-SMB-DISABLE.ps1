#Connect EXO
. .\Login-EXO.ps1

#Connect Azure AD
. .\Login-AzureAD.ps1

#Get all shared mailboxes
$SMBS = Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize Unlimited

#Set all SMBS on Jobtitle Shared Mailbox and set AccountEnabled on false
ForEach ($SMB in $SMBS) {
Set-AzureADUser -ObjectId $SMB.UserPrincipalname -JobTitle 'Shared Mailbox' -AccountEnabled $false
}


#Rollback AccountEnabled: Set-AzureADUser -ObjectId $SMB.UserPrincipalname -AccountEnabled $true
#Rollback JobTitle: Remove-AzureADUserExtension -ObjectId $Member.UserPrincipalname -ExtensionName "JobTitle"
