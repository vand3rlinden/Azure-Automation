#This script sets reviewer access for the default user (open calenders)

#Connect to exchange online
. .\Login-EXO.ps1

#Get all mailboxes, but exclude some UPNs #Single user? Use '-notlike' instead of '-notin'
$Mailboxes =  (Get-Mailbox -RecipientTypeDetails UserMailbox -ResultSize Unlimited | Where-Object {$_.UserPrincipalName -notin 'UPN1', 'UPN2'}).UserPrincipalName
$AccessRights = "Reviewer"
$Silent = "SilentlyContinue"

#Get all calenders with English name: Calendar
ForEach ($Mailbox in $Mailboxes){
    Set-MailboxFolderPermission -Identity "$($Mailbox):\Calendar" -User Default -AccessRights $AccessRights -ErrorAction $Silent -WarningAction $Silent
}

#Get all calenders with Dutch name: Agenda
ForEach ($Mailbox in $Mailboxes){
    Set-MailboxFolderPermission -Identity "$($Mailbox):\Agenda" -User Default -AccessRights $AccessRights -ErrorAction $Silent -WarningAction $Silent
}

<# You can add more languages
#Get all calenders with XXXX name: XXXXX
ForEach ($Mailbox in $Mailboxes){
    Set-MailboxFolderPermission -Identity "$($Mailbox):\XXXX" -User Default -AccessRights $AccessRights -ErrorAction $Silent -WarningAction $Silent
}
#>

#To prevent the script from failing with a maximum of 3 allowed connections to EXO.
Get-PSSession | Remove-PSSession
