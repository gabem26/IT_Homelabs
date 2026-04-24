$Users = Get-ADUser -Filter * -SearchBase "OU=New Hires,OU=LAB Users,DC=LAB,DC=local"

ForEach ($User in $Users) {
    $Email = "$($User.SamAccountName)@LAB.local"
    Set-ADUser -Identity $User -EmailAddress $Email
    Write-Host "Set email for $($User.SamAccountName) to $Email"
}
