#This script has been made if an attribute is missing from an user object, and if missing it sends a ticket to the servicedesk. You can tweak this script for your needs.

##Login in EXO##
$Credentials = Get-AutomationPSCredential -Name 'C-VAND3RLINDEN-AUTOMATION'
# import the EXO module
Import-Module ExchangeOnlineManagement
# Connect to ExchangeOnline
Connect-ExchangeOnline -Credential $Credentials
##End Login EXO##

# Get admin accounts without CompanyName
$admins = Get-AzureADUser -All $true | Where-Object {($_.UserPrincipalName -like 'adm_*') -and ($_.CompanyName -like '')} | Select-Object Displayname,UserPrincipalName

#SMTP Service Account with EXO license
$SENDMAIL = Get-AutomationPSCredential -Name 'C-VAND3RLINDEN-SENDMAIL'

#Send from Office 365 SMTP
$PSEmailServer = "smtp.office365.com"
$SMTPPort = 587
$MailTo = "servicedesk@domain.com"
$MailFrom = "svc_smtp@domain.com"
$MailSubject = "Admin accounts without CompanyName attribute"
Send-MailMessage -From $MailFrom -To $MailTo -Subject $MailSubject -Body ($admins | Out-String) -UseSsl -Port $SMTPPort -Credential $SENDMAIL
