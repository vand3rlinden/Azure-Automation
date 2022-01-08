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

if ($user.RetentionPolicy -eq "Default MRM Policy") {Write-Host alles is goed} else {Set-Mailbox -Identity $user.Name –RetentionPolicy "Default MRM Policy"}
}
