#This script can be used to give your guest users more idenity in your tenant to set comanyName attribute

#Connect Azure AD
. .\Login-AzureAD.ps1

#Guest CompanyNames
$Companies = @('Contoso','Fabrikram')

#Get guest users with UPN like: company.extension#EXT#@domain.onmicrosoft.com
foreach ($Company in $Companies){
    $Members = (Get-AzureADUser -All $true | Where-Object {$_.UserPrincipalName -like "*$Company.*"}).UserPrincipalname

    #Set CompanyName
    foreach ($Member in $Members){
        Set-AzureADUser -ObjectId $Member -CompanyName $Company #Set
        #Get-AzureADUser -ObjectId $Member | Select-Object UserPrincipalname #Test
        #Remove-AzureADUserExtension -ObjectId -ObjectId $Member -ExtensionName "CompanyName" #Rollback
    }
}
