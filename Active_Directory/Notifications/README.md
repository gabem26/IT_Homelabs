# Notifications Automation

Automated email alert system that monitors Active Directory for password expiry warnings and account lockouts, and sends notifications via the Mailtrap API.

## What It Does

### Password Expiry Notifier
- Scans AD for users whose passwords expire within a configurable threshold (default: 30 days)
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
| `notifier_log.txt` | Generated log for password expiry runs |
| `lockedaccount_log.txt` | Generated log for lockout alert runs |

## How It Works
Both scripts use the **Mailtrap API** with `Invoke-RestMethod` and an API token for authenticated email delivery. This approach is more reliable and modern than SMTP and does not require an existing mail server in the lab environment.

## How to Use
1. Update the configuration block at the top of each script with your API token and target addresses
2. Adjust `$DaysThreshold` in the password notifier to match your notification window
3. Run from PowerShell:
```powershell
& "C:\Scripts\Notifications\PasswordExpiryNotifier.ps1"
& "C:\Scripts\Notifications\AccountLockoutNotifier.ps1"
```
4. Review log files for a full timestamped audit trail

## Recommended Usage
Schedule both scripts using **Windows Task Scheduler** to run automatically:
- Password Expiry Notifier — daily at 8:00 AM
- Locked Account Notifier — every hour

## Requirements
- Windows Server with Active Directory Domain Services
- PowerShell ActiveDirectory module
- Mailtrap account with a valid API token
