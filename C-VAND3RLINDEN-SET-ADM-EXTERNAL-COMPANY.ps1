#This script can be used to give internal admins from external companies more identity in your tenant

#Connect Azure AD with Runbook:
. .\Login-AzureAD.ps1

#List external companies
$Companies = @('Contoso','Wortell')

#Get accounts with a DisplayName like (CompanyName Admin)
foreach ($Company in $Companies){
    $Members = (Get-AzureADUser -All $true | Where-Object {$_.DisplayName -like "*($Company Admin)"}).UserPrincipalname
    
    #Set CompanyName
    foreach ($Member in $Members){
        Set-AzureADUser -ObjectId $Member -CompanyName $Company #Set
        #Get-AzureADUser -ObjectId $Member | Select-Object UserPrincipalname #Test
        #Remove-AzureADUserExtension -ObjectId -ObjectId $Member.UserPrincipalname -ExtensionName "CompanyName" #Rollback
    }
}
