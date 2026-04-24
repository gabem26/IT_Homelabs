#Config
$SearchBase    = "OU=New Hires,OU=LAB Users,DC=LAB,DC=local"
$TheDayTheUserWillGetTheNoti = 5 #threshold to change pass
$LogPath       = "C:\Scripts\Notifications\notifier_log.txt"

#Logging func
Function Write-Log {
    Param([string]$Message)
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Entry     = "$Timestamp - $Message"
    Write-Host $Entry
    Add-Content -Path $LogPath -Value $Entry
}

#Days left simulator func -- to manually get to 5 days left
Function DaysLeftToFive {
    Param([int]$DaysLeft)
    while ($DaysLeft -ne $TheDayTheUserWillGetTheNoti -and $DaysLeft -ge $TheDayTheUserWillGetTheNoti){
        $DaysLeft -= 1;
    }
    return $DaysLeft
}

#Get domain password policy -- to calc expiry date from PasswordLastSet
$MaxPasswordAge = (Get-ADDefaultDomainPasswordPolicy).MaxPasswordAge # 30

#Import Users
$Users = Get-ADUser -Filter * -SearchBase $SearchBase -Properties PasswordLastSet, EmailAddress, PasswordNeverExpires
Write-Log "Starting password expiry check, $($Users.Count) user(s) found."


#Mailtrap API Settings
$ApiToken    = ""
$ApiEndpoint = ""

#Main loop
ForEach ($User in $Users) {

    If ($User.PasswordNeverExpires) {
        Write-Log "SKIPPED - $($User.SamAccountName) password never expires."
        Continue
    }

    If (-not $User.PasswordLastSet) {
        Write-Log "SKIPPED - $($User.SamAccountName) has no PasswordLastSet date."
        Continue
    }

    $ExpiryDate  = $User.PasswordLastSet + $MaxPasswordAge 
    $DaysLeft    = ($ExpiryDate - (Get-Date)).Days #27,26... in this case but I want it to simulate 5 days left immediately
    $DaysLeft = DaysLeftToFive $DaysLeft

    If ($DaysLeft -le $TheDayTheUserWillGetTheNoti -and $DaysLeft -ge 0) {
        Write-Log "EXPIRING - $($User.SamAccountName) password expires in $DaysLeft day(s) on $($ExpiryDate.ToShortDateString())."

    $To      = $User.EmailAddress
    $From    = "IT-Alerts@LAB.local"
    $Subject = "Action Required: Your password expires in $DaysLeft day(s)"
    $Body    = @"
Hello $($User.GivenName),

This is an automated reminder from IT.

Your network password will expire on $($ExpiryDate.ToShortDateString()) — $DaysLeft day(s) from today.

Please change your password before this date to avoid being locked out.

If you need assistance, contact the IT Helpdesk.

IT Department
LAB.local
"@

    #API request
    $Headers = @{
        "Authorization" = "Bearer $ApiToken"
        "Content-Type"  = "application/json"
    }

    $RequestBody = @{
        from = @{
            email = $From
        }
        to = @(
            @{
                email = $To
            }
        )
        subject = $Subject
        text    = $Body
    } | ConvertTo-Json -Depth 5

    Try {
        $null = Invoke-RestMethod -Uri $ApiEndpoint -Method Post -Headers $Headers -Body $RequestBody
        Write-Log "EMAIL SENT - Notified $($User.SamAccountName) at $To."
        Start-Sleep -Seconds 15
    } Catch {
        Write-Log "ERROR - Could not send email to $($User.SamAccountName). Reason: $_"
    }

    } ElseIf ($DaysLeft -lt 0) {
        Write-Log "EXPIRED - $($User.SamAccountName) password already expired $([math]::Abs($DaysLeft)) day(s) ago."
    } Else {
        Write-Log "OK - $($User.SamAccountName) password expires in $DaysLeft day(s). No action needed."
    }

}

Write-Log "Password expiry check complete."
