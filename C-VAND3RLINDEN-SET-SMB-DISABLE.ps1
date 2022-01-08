#By default a shared mailbox is an active account, you can disabled a SMB without the loss of functioning. This script will automate the proccess. 

##Login in EXO##
$Credentials = Get-AutomationPSCredential -Name 'C-VAND3RLINDEN-AUTOMATION'
# import the EXO module
Import-Module ExchangeOnlineManagement
# Connect to ExchangeOnline
Connect-ExchangeOnline -Credential $Credentials
##End Login EXO##

##Login Azure AD##
$Credentials = Get-AutomationPSCredential -Name 'C-VAND3RLINDEN-AUTOMATION'
# import AzureAD module
Import-Module AzureAD
# Connect to AzureAD
Connect-AzureAD -Credential $Credentials
##End Login Azure AD##

#Get all shared mailboxes
$SMBS = Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize Unlimited

#Set all SMBS on Jobtitle Shared Mailbox and set AccountEnabled on false
ForEach ($SMB in $SMBS) {
Set-AzureADUser -ObjectId $SMB.UserPrincipalname -JobTitle 'Shared Mailbox' -AccountEnabled $false
}


#Rollback AccountEnabled: Set-AzureADUser -ObjectId $SMB.UserPrincipalname -AccountEnabled $true
#Rollback JobTitle: Remove-AzureADUserExtension -ObjectId $Member.UserPrincipalname -ExtensionName "JobTitle"
