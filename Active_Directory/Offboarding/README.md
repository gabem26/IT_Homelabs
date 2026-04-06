# Offboarding Automation

Automates the offboarding process for terminated employees by disabling their AD accounts, removing group memberships, and relocating them to a Disabled Users OU.

## What It Does
- Reads terminated user list from a CSV file
- Verifies each account exists in AD before processing
- Disables the AD account
- Removes the user from all security groups
- Moves the account to the Disabled Users OU
- Logs every action with timestamps for auditing

## Files
| File | Description |
|---|---|
| `Offboarding.ps1` | Main automation script |
| `terminated_users.csv` | List of accounts to offboard |
| `offboarding_log.txt` | Generated log file (created on first run) |

## CSV Format
```csv
SamAccountName
jsmith
....and so on
```

## How to Use
1. Populate `terminated_users.csv` with the SamAccountNames of terminated users
2. Verify the Disabled OU path in the configuration block matches your environment
3. Run the script from PowerShell:
```powershell
& "C:\Scripts\Offboarding\Offboarding.ps1"
```
4. Review `offboarding_log.txt` for a full audit trail

## Requirements
- Windows Server with Active Directory Domain Services
- PowerShell ActiveDirectory module
- Disabled Users OU must exist before running
