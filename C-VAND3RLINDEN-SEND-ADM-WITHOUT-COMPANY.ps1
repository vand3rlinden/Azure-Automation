#Connect Azure AD
. .\Login-AzureAD.ps1

# Get admin accounts without CompanyName
$admins = Get-AzureADUser -All $true | Where-Object {($_.UserPrincipalName -like 'adm_*') -and ($_.CompanyName -like '')} | Select-Object Displayname,UserPrincipalName

#SMTP Service Account with EXO license
$SENDMAIL = Get-AutomationPSCredential -Name 'C-VAND3RLINDEN-SENDMAIL'

#Send from Office 365 SMTP
$PSEmailServer = "smtp.office365.com"
$SMTPPort = 587
$MailTo = "ricardo@sandbox.vand3rlinden.nl"
$MailFrom = "svc_smtp@sandbox.vand3rlinden.nl"
$MailSubject = "Admin accounts without CompanyName attribute"
Send-MailMessage -From $MailFrom -To $MailTo -Subject $MailSubject -Body ($admins | Out-String) -UseSsl -Port $SMTPPort -Credential $SENDMAIL