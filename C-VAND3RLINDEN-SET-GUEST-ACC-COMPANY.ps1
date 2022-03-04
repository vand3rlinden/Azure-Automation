<#
This script can be used to give your guest users more idenity in your tenant to set comanyName attribute
Command in: Set-AzureADUser and command out: Get-AzureADUser with the $Export variable to check the output your are changing
Command in: Set-AzureADUser and command out: Remove-AzureADUserExtension to roll back the script
#>

#Connect Azure AD
. .\Login-AzureAD.ps1

#Guest CompanyNames
$Companies = @('Contoso','Fabrikram')

#Get guest users with UPN like: company.extension#EXT#@domain.onmicrosoft.com
#$Export = foreach ($Company in $Companies){ #Comment out for: Test
foreach ($Company in $Companies){
    $Members = (Get-AzureADUser -All $true | Where-Object {$_.UserPrincipalName -like "*$Company.*"}).UserPrincipalname

    #Set CompanyName
    foreach ($Member in $Members){
        Set-AzureADUser -ObjectId $Member -CompanyName $Company
        #Get-AzureADUser -ObjectId $Member | Select-Object UserPrincipalName,DisplayName #Comment out for: Test
        #Remove-AzureADUserExtension -ObjectId -ObjectId $Member -ExtensionName "CompanyName" #Comment out for: Rollback
    }
}
#$Export | Export-CSV -Path "C:\Temp\file3.csv" -NoTypeInformation #Comment out for: Test
