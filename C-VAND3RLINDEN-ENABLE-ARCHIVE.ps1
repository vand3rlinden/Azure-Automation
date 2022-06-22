# This script enabled the archive and set the default RetentionPolicy to 'Default MRM Policy'. This Retention RetentionPolicy has tag: 
## "Recoverable Items 14 days move to archive" to avoid that the "Recoverable Items" folder reached the quota of 30GB.

#Connect EXO with Runbook:
. .\Login-EXO.ps1

#Enable Archive
Get-Mailbox -Filter {ArchiveStatus -Eq "None" -AND RecipientTypeDetails -eq "UserMailbox"} | Enable-Mailbox -Archive

#Set Retention Policy on "Default MRM Policy"
$defaultpolicy = Get-Mailbox -ResultSize unlimited | Select-Object RetentionPolicy, name

foreach($user in $defaultpolicy){

if ($user.RetentionPolicy -eq "Default MRM Policy") {Write-Host Everything looks okay} else {Set-Mailbox -Identity $user.Name –RetentionPolicy "Default MRM Policy"}
}
