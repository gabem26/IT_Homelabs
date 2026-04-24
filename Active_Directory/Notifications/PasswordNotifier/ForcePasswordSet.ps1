$Users = Get-ADUser -Filter * -SearchBase "OU=New Hires,OU=LAB Users,DC=LAB,DC=local"

ForEach ($User in $Users) {

    Set-ADAccountPassword -Identity $User -Reset -NewPassword (ConvertTo-SecureString "VerySecure" -AsPlainText -Force)
    Write-Host "Password set for $($User.SamAccountName)"
}
