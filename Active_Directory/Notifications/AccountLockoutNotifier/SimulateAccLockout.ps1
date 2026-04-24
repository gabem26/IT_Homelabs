$Password = ConvertTo-SecureString "theWrongPassword" -AsPlainText -Force
$Cred     = New-Object System.Management.Automation.PSCredential("DOMAIN\user", $Password)

1..10 | ForEach-Object {

    Try {
        Start-Process cmd -Credential $Cred -WindowStyle Hidden -ErrorAction Stop
    } Catch {}
}
