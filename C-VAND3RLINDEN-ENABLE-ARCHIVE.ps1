#Login in EXO
. .\Login-EXO.ps1

#Enable Archive
Get-Mailbox -Filter {ArchiveStatus -Eq "None" -AND RecipientTypeDetails -eq "UserMailbox"} | Enable-Mailbox -Archive

#Set Retention Policy on "Default MRM Policy"
$defaultpolicy = Get-Mailbox -ResultSize unlimited | Select-Object RetentionPolicy, name

foreach($user in $defaultpolicy){

if ($user.RetentionPolicy -eq "Default MRM Policy") {Write-Host alles is goed} else {Set-Mailbox -Identity $user.Name –RetentionPolicy "Default MRM Policy"}
}