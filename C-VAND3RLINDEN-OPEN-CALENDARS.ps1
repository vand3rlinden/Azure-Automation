#Connect to exchange online
. .\Login-EXO.ps1

#Set Access Rights
$Accessrights = "Reviewer"

#Get all mailboxes
Foreach ($mbx in (Get-Mailbox -ResultSize Unlimited | Where-Object {$_.Name -notin 'Name1', 'Name2'})) #Single user? Use '-notlike' instead of '-notin' !!Name = not UPN!!
{
    #Get-MailboxFolderStatistics for FolderScope Calendar regarding the differents terms for all countries
    $Result = ((Get-MailboxFolderStatistics -identity $mbx.PrimarySmtpAddress -FolderScope Calendar | Where-Object {$_.foldertype -eq "Calendar"}).identity)
    $Calendar = $result.insert($result.IndexOf('\'), ':')

    #Set-MailboxFolderPermission all mailboxes on Accessrights
    Set-MailboxFolderPermission -identity $Calendar -User Default -AccessRights $Accessrights -ErrorAction SilentlyContinue
}