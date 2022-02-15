<#
Script purpose: Having a mail group based on members of an AAD SG
Unfortunately, Azure AD Security Groups cannot be mail-enabled groups. With Azure Automation you could do a query to the AAD SG and compare members with an EXO, so it will be up and down- scaled.
- Having an EXO MSG, just don't fill the needs, because you cannot use this type of group within Access Packages in Azure AD.
- Having an EXO DDL, also don't fill the needs, because the users in a requested AAD SG, do not have the same criteria to filter on. The only thing the users have in common, is the membership of an AAD SG.
Requirement: You must have an EXO DL with atleast one member.
#>

#Connect EXO with Runbook:
. .\Login-EXO.ps1

#Connect Azure AD with Runbook:
. .\Login-AzureAD.ps1

#Azure AD: Get AAD SG
$AzureADGroup = "xxx-xxxx-xxx-xxx-xxx-xx-x-xxxx"
$AzureADGroupMembers = (Get-AzureADGroupMember -ObjectId $AzureADGroup -All $true).Mail

#EXO: Get EXO DG (EXO DG group cannot be empty, please fill atleast with one member)
$DG = "DG1@vand3rlinden.nl"
$DGMembers = (Get-DistributionGroupMember -identity $DG).PrimarySmtpAddress


# SideIndicator: "<=" = NOT IN EXO DG - ADD AAD SG GROUPMEMBER TO EXO DG THAT ARE NOT IN THE EXO DG
Compare-Object -ReferenceObject $AzureADGroupMembers -DifferenceObject $DGMembers | Where-Object {$_.SideIndicator -eq "<="} | ForEach-Object {
    Add-DistributionGroupMember -Identity $DG -Member $_.InputObject -Confirm:$false
    Write-Host -ForegroundColor Green $_.InputObject "is added"
}

# SideIndicator: "=>" = NOT IN AAD SG - REMOVE EXO DG GROUPMEMBER THAT ARE NOT IN AAD SG
Compare-Object -ReferenceObject $AzureADGroupMembers -DifferenceObject $DGMembers | Where-Object {$_.SideIndicator -eq "=>"} | ForEach-Object {
    Remove-DistributionGroupMember -Identity $DG -Member $_.InputObject -Confirm:$false
    Write-Host -ForegroundColor Red $_.InputObject "is removed"
}

Write-Host -ForegroundColor Green "Script is finished!"

#To prevent the script from failing with a maximum of 3 allowed connections to EXO.
Get-PSSession | Remove-PSSession
