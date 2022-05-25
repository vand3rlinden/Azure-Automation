<#
This script can be used to give your guest users more idenity in your tenant to set comanyName attribute
Command in: Set-AzureADUser and command out: Get-AzureADUser with the $Export variable to check the output your are changing
Command in: Set-AzureADUser and command out: Remove-AzureADUserExtension to roll back the script

Note: in most scenarios the domain name match the company name, like contoso.com. But there are examples where it does not, like: f-s.com and companyname is FourStar.
In that scenario you could add below script for each of that company:
$Members = (Get-AzureADUser -All $true | Where-Object {$_.UserPrincipalName -like "*f-s.com*"}).UserPrincipalname
ForEach ($Member in $Members){
    Set-AzureADUser -ObjectId $Member.UserPrincipalname -CompanyName 'FourStar'
}
#>

#Connect Azure AD
. .\Login-AzureAD.ps1

#Guest CompanyNames
$Companies = @('Contoso','Fabrikram')

#Get guest users with UPN like: companyname.extension#EXT#@domain.onmicrosoft.com (we only take 'companyname.', because guest can have different domain extensions)
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
