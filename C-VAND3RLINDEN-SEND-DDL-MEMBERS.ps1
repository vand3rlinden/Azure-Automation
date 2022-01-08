#This script can be used to send monthly all the users of an all company DDL to your HR department

##Login in EXO##
$Credentials = Get-AutomationPSCredential -Name 'C-VAND3RLINDEN-AUTOMATION'
# import the EXO module
Import-Module ExchangeOnlineManagement
# Connect to ExchangeOnline
Connect-ExchangeOnline -Credential $Credentials
##End Login EXO##

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
