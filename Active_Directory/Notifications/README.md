# Notifications Automation

Automated email alert system that monitors Active Directory for password expiry warnings and account lockouts, and sends notifications via the Mailtrap API.

## What It Does

### Password Expiry Notifier
- Scans AD for users whose passwords expire within a threshold (5 days left)
- Sends a personalized email to each affected user with their exact expiry date
- Logs users as EXPIRING, EXPIRED, or OK with timestamps
- Skips accounts where password never expires or have no expiry date set

### Locked Account Notifier
- Scans AD for any currently locked out accounts
- Sends a single summary alert email to the IT admin listing all locked accounts
- Exits cleanly with a log entry if no locked accounts are found

## Files
| File | Description |
|---|---|
| `PasswordExpiryNotifier.ps1` | Scans AD and emails users approaching password expiry |
| `AccountLockoutNotifier.ps1` | Scans AD and emails admin when accounts are locked |
| `NotifierLog.txt` | Generated log for password expiry runs |
| `LockedAccountLog.txt` | Generated log for lockout alert runs |
| `SetupEmailAddresses.ps1` | Setup all email addresses for each AD user within the New Hires OU |
| `ForcePasswordSet` | Populate a date into the PasswordLastSet property |
| `SimulateAccLockout.ps1` | Lock user accounts for testing purposes | 

## How It Works
Both scripts use the **Mailtrap API** with `Invoke-RestMethod` and an API token for authenticated email delivery. (more reliable/modern than SMTP)

## How to Use
1. Update the configuration block at the top of each script with your API token and target addresses
2. Adjust `$DaysThreshold` in the password notifier to match your notification window
3. Run from PowerShell:
```powershell
& "C:\Scripts\Notifications\PasswordExpiryNotifier.ps1"
& "C:\Scripts\Notifications\AccountLockoutNotifier.ps1"
```
4. Review the logs for audit purposes

## Recommended Usage
Schedule both scripts using **Windows Task Scheduler** to run automatically:
- Password Expiry Notifier check— each business day 
- Locked Account Notifier check — during business hours

## Requirements
- Windows Server with Active Directory Domain Services
- PowerShell ActiveDirectory module
- Mailtrap account with a valid API token
