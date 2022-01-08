#Connect to exchange online
. .\Login-EXO.ps1

# Get DDL
$FTE = Get-DynamicDistributionGroup "iedereen@sandbox.vand3rlinden.nl"
 
# Get Members
$members = Get-Recipient -RecipientPreviewFilter $FTE.RecipientFilter -OrganizationalUnit $FTE.RecipientContainer -ResultSize Unlimited | Select-Object Identity,PrimarySmtpAddress

#SMTP Service Account with EXO license
$SENDMAIL = Get-AutomationPSCredential -Name 'C-VAND3RLINDEN-SENDMAIL'

#Send from Office 365 SMTP
$PSEmailServer = "smtp.office365.com"
$SMTPPort = 587
$MailTo = "ricardo@sandbox.vand3rlinden.nl"
$MailFrom = "svc_smtp@sandbox.vand3rlinden.nl"
$MailSubject = "Export from DynamicGroup: iedereen@sandbox.vand3rlinden.nl"
Send-MailMessage -From $MailFrom -To $MailTo -Subject $MailSubject -Body ($members | Out-String) -UseSsl -Port $SMTPPort -Credential $SENDMAIL