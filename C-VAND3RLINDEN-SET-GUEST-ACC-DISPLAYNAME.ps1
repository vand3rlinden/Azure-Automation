<#
In the need of setting the company name of your known guest users in the Displayname? Like for guest users that are created with IG by using access packages 
for connected organizations. This script will obtain all guest users of the companies that are listed in '$Company' and set the Displayname to:
Current Displayname, like 'Firstname Lastname (CompanyName)'
#>

#Connect Azure AD
. .\Login-AzureAD.ps1

#Guest CompanyNames
$Companies = @('Outlook','Wortell')

#Get guest users with UPN like: company.extension#EXT#@domain.onmicrosoft.com
#$Export = foreach ($Company in $Companies){ #Comment out for: Test
Foreach ($Company in $Companies){
    $Users = Get-AzureADUser -All $true | Where-Object {($_.UserPrincipalName -like "*$Company.*") -and ($_.DisplayName -notlike "*($Company)")}

    foreach ($User in $Users){
        $DisplayName = $Users.DisplayName + " " + "($Company)"
        Set-AzureADUser -ObjectId $Users.ObjectId -Displayname $DisplayName
        #Get-AzureADUser -ObjectId $Users.ObjectId | Select-Object UserPrincipalName,DisplayName #Comment out for: Test
    }
    
}
#$Export | Export-CSV -Path "C:\Temp\file3.csv" -NoTypeInformation #Comment out for: Test
