# Onboarding Automation

Automates the onboarding process for new hires by reading a CSV file and creating fully configured Active Directory accounts.

## What It Does
- Reads new hire data from a CSV file simulating an HR data feed
- Generates usernames automatically (first initial + last name)
- Creates AD accounts with full attributes (name, title, department, manager)
- Places accounts in the correct Organizational Unit
- Assigns users to their department security group
- Skips accounts that already exist to prevent duplicates
- Logs every action with timestamps for auditing

## Files
| File | Description |
|---|---|
| `Onboarding.ps1` | Main automation script |
| `new_hires.csv` | Sample HR data feed |
| `onboarding_log.txt` | Generated log file (created on first run) |

## CSV Format
```csv
FirstName,LastName,Department,JobTitle,Manager
John,Smith,IT,Helpdesk Technician,Administrator
```
> Department must match an existing AD security group name exactly.

## How to Use
1. Populate `new_hires.csv` with new hire data
2. Verify the OU and domain values in the configuration block match your environment
3. Run the script from PowerShell:
```powershell
& "C:\Scripts\Onboarding\Onboarding.ps1"
```
4. Review `onboarding_log.txt` for a full audit trail

## Requirements
- Windows Server with Active Directory Domain Services
- PowerShell ActiveDirectory module
- Target OUs and security groups must exist before running
