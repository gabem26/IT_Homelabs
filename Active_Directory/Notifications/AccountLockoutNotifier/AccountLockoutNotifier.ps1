#Config
$SearchBase = "OU=New Hires,OU=LAB Users,DC=LAB,DC=local"
$LogPath    = "C:\Scripts\Notifications\AccountLockoutNotifier\lockedaccountlog.txt"
$AdminEmail = "admin@LAB.local"

#Mailtrap API Settings
$ApiToken    = ""
$ApiEndpoint = ""

#Logging func
Function Write-Log {
    Param([string]$Message)
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Entry     = "$Timestamp - $Message"
    Write-Host $Entry
    Add-Content -Path $LogPath -Value $Entry
}

#Get locked accounts
$LockedUsers = Search-ADAccount -LockedOut -SearchBase $SearchBase -UsersOnly
Write-Log "Starting locked account check. $($LockedUsers.Count) locked account(s) found."

#If no locked accounts, log and exit
if ($LockedUsers -eq 0){
    Write-Log "No locked accounts found. No action needed."
    exit
}

#Build account list for email body if locked accounts exist
$AccountList = ""
ForEach ($User in $LockedUsers){
    $AccountList += " - $($User.Name) ($($User.SamAccountName))`n"
    Write-Log "Locked - $($User.SamAccountName)"
}

#Build and send admin alert via email
    $From    = "IT-Alerts@LAB.local"
    $Subject = "IT Alert: $($LockedUsers.Count) Locked Account(s) Detected"
    $Body    = @"
IT Admin,

The following Active Directory accounts are currently locked out:

$AccountList
Please investigate and unlock accounts as appropriate.

This is an automated alert from the LAB.local domain.

IT Automation
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
            email = $AdminEmail #To
        }
    )
    subject = $Subject
    text    = $Body
} | ConvertTo-Json -Depth 5

Try {
    $null = Invoke-RestMethod -Uri $ApiEndpoint -Method Post -Headers $Headers -Body $RequestBody
    Write-Log "EMAIL SENT - Admin alerted at $AdminEmail for $($LockedUsers.Count) locked account(s)."
} Catch {
    Write-Log "ERROR - Could not send admin alert. Reason: $_"
}

   
