# azure-automation
This scripts can be used to manage Azure AD and Microsoft 365.

The scripts contains seperate runbooks to login to Azure AD or Exchange Online

### Runbook: Login-AzureAD.ps1

# Get Automation credentials
if (!($CredAzureAD)) {
    $CredAzureAD = Get-AutomationPSCredential -Name 'YOUR-AUTOMATION-ACCOUNT'
}

# import the AzureAD module
Import-Module AzureAD
# Connect to AzureAD
Connect-AzureAD -Credential $CredAzureAD

### Runbook: Login-EXO
# Get Automation credentials
if (!($Cred365)) {
    $Cred365 = Get-AutomationPSCredential -Name 'YOUR-AUTOMATION-ACCOUNT'
}

# import the EXO module
Import-Module ExchangeOnlineManagement
# Connect to ExchangeOnline
Connect-ExchangeOnline -Credential $Cred365