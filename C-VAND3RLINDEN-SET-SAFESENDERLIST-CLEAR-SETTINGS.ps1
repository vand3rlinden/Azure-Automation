<# 
    This script will clear all settings users have been set in the junk email setting.

    Junk email settings are availible in OWA by going to Settings >> View all outlook settings >> Mail >> Junk email
    ContactsTrusted:            checked out Trust email from my contacts
    TrustedListsOnly:           checkd out Only trust email from addresses in my Safe sender and domain list
    TrustedSendersAndDomains:   clears Safe senders and domain list
    BlockedSendersAndDomains:   clears Blocked senders and domain list
#>

#Connecting EXO
. .\Login-EXO.ps1

#Clear MailboxJunkEmailConfiguration
Get-Mailbox -ResultSize unlimited | Set-MailboxJunkEmailConfiguration -ContactsTrusted $false -TrustedListsOnly $false -TrustedSendersAndDomains $Null -BlockedSendersAndDomains $Null

