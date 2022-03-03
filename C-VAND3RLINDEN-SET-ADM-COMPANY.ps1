#This script can be used to autofill an attribute based on displayname. For example, your external admin accounts.

#Connect Azure AD with Runbook:
. .\Login-AzureAD.ps1

$Companies = @('Contoso', 'Fabrikam')
try {
    # Get all the users in the tenant
    $Members = Get-AzureADUser -All $true -ErrorAction Stop
    foreach ($Company in $Companies) {
        $Members | Where-Object {$_.DisplayName -like "*($Company Admin)"}
        foreach ($Member in $Members) {
            try {
                # Set the Company attribute
                Set-AzureADUser -ObjectId $Member.UserPrincipalname -CompanyName $Company -ErrorAction Stop
                #Rollback: Remove-AzureADUserExtension -ObjectId -ObjectId $Member.UserPrincipalname -ExtensionName "CompanyName"
            } catch {
                Write-Error "Unable to Set AD properties for user '$($Member.UserPrincipalName)'.`nError: $($_.Exception.Message)"
            }
        }
    }
} catch {
    Write-Error "Unable to get Azure AD Users.`nError: $($_.Exception.Message)"
}
