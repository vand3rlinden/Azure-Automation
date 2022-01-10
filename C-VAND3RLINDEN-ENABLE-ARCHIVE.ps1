#This script enabled the archive and set the default RetentionPolicy to 'Default MRM Policy'. This Retention RetentionPolicy has tag: 
##"Recoverable Items 14 days move to archive" to avoid that the "Recoverable Items" folder reached the quota of 30GB.

##Login in EXO##
$Credentials = Get-AutomationPSCredential -Name 'C-VAND3RLINDEN-AUTOMATION'
# import the EXO module
Import-Module ExchangeOnlineManagement
# Connect to ExchangeOnline
Connect-ExchangeOnline -Credential $Credentials
##End Login EXO##

#Enable Archive
Get-Mailbox -Filter {ArchiveStatus -Eq "None" -AND RecipientTypeDetails -eq "UserMailbox"} | Enable-Mailbox -Archive

#Set Retention Policy on "Default MRM Policy"
$defaultpolicy = Get-Mailbox -ResultSize unlimited | Select-Object RetentionPolicy, name

foreach($user in $defaultpolicy){

if ($user.RetentionPolicy -eq "Default MRM Policy") {Write-Host Everything looks okay} else {Set-Mailbox -Identity $user.Name –RetentionPolicy "Default MRM Policy"}
}
