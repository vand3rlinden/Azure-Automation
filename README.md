# Azure Automation
This scripts can be used to manage Azure AD + Microsoft 365 for automate some processes. Each script connect to seperate runbooks for login to Azure AD and Exchange Online with Azure Automation.

C-VAND3RLINDEN-OPEN-CALENDARS.ps1 is not written by myself but obtain this one from a colleague.

# Runbook: Login-AzureAD.ps1
```
#Get Automation credentials
if (!($CredAzureAD)) {
    $CredAzureAD = Get-AutomationPSCredential -Name 'YOUR-AUTOMATION-ACCOUNT'
}

#import the AzureAD module
Import-Module AzureAD

#Connect to AzureAD
Connect-AzureAD -Credential $CredAzureAD
```

# Runbook: Login-EXO.ps1
```
#Get Automation credentials
if (!($Cred365)) {
    $Cred365 = Get-AutomationPSCredential -Name 'YOUR-AUTOMATION-ACCOUNT'
}

#import the EXO module
Import-Module ExchangeOnlineManagement

#Connect to ExchangeOnline
Connect-ExchangeOnline -Credential $Cred365
```
