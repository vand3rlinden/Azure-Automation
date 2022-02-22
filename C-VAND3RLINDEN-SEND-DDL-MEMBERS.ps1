#This script can be used to send monthly all the users of an all company DDL to your HR department

#Connect EXO with Runbook:
. .\Login-EXO.ps1

# Get DDL
$FTE = Get-DynamicDistributionGroup "everyone@domain.com"
 
# Get Members
$members = Get-Recipient -RecipientPreviewFilter $FTE.RecipientFilter -OrganizationalUnit $FTE.RecipientContainer -ResultSize Unlimited | Select-Object Identity,PrimarySmtpAddress

#SMTP Service Account with EXO license
$SENDMAIL = Get-AutomationPSCredential -Name 'C-VAND3RLINDEN-SENDMAIL'

#Send from Office 365 SMTP
$PSEmailServer = "smtp.office365.com"
$SMTPPort = 587
$MailTo = "hr@domain.com"
$MailFrom = "svc_smtp@domain.com"
$MailSubject = "Export from DynamicGroup: everyone@domain.com"
Send-MailMessage -From $MailFrom -To $MailTo -Subject $MailSubject -Body ($members | Out-String) -UseSsl -Port $SMTPPort -Credential $SENDMAIL
