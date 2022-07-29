#Connecting EXO
. .\Login-EXO.ps1

#Clear TrustedSendersAndDomains and BlockedSendersAndDomains
Set-MailboxJunkEmailConfiguration "user@domain.com" -TrustedSendersAndDomains $Null -BlockedSendersAndDomains $Null

#Turn off ContactsTrusted
Set-MailboxJunkEmailConfiguration "user@domain.com" -ContactsTrusted $false

#Turn off TrustedListsOnly 
Set-MailboxJunkEmailConfiguration "user@domain.com" -ContactsTrusted $false
