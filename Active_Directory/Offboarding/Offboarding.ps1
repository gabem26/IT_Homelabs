#config
$CsvPath     = "C:\Scripts\Offboarding\terminated_users.csv"
$DisabledOU  = "OU=Disabled Users,OU=LAB Users,DC=LAB,DC=local"
$LogPath     = "C:\Scripts\Offboarding\offboarding_log.txt"

#logging func
Function Write-Log {
    Param([string]$Message)
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Entry     = "$Timestamp - $Message"
    Write-Host $Entry
    Add-Content -Path $LogPath -Value $Entry
}

#import CSV
$TerminatedUsers = Import-Csv -Path $CsvPath
Write-Log "Starting offboarding run. $($TerminatedUsers.Count) user(s) found in CSV." 

#loop -- disabled, group removal and OU move
ForEach ($User in $TerminatedUsers){
    #check if user exists and also grab their group memberships to loop and remove them all
    $SAM = $User.SamAccountName
    $ADUser = Get-ADUser -Filter {SamAccountName -eq $SAM} -Properties MemberOf -ErrorAction SilentlyContinue

    If (-not $ADUser) #if user does not exist, skip/continue 
    {
        Write-Log "Skipped - $($User.SamAccountName) not found in AD."
        Continue
    }

    #disable the account
    Try {
        Disable-ADAccount -Identity $ADUser
        Write-Log "Disabled - $($User.SamAccountName)"
    } Catch {
        Write-Log "Error - Could not disable $($User.SamAccountName). Reason: $_"
        Continue
    }

    #remove all security groups -- MemberOf returns all groups except Domain Users
    Try {
        ForEach ($Group in $ADUser.MemberOf){
            Remove-ADGroupMember -Identity $Group -Members $ADUser -Confirm:$false
            Write-Log "Group Removed - $($User.SamAccountName) removed from $Group."
        }
    } Catch {
        Write-Log "Error - Could not remove $($User.SamAccountName) from groups. Reason: $_"
    }

    #move account to Disabled Users OU
    Try {
        Move-ADObject -Identity $ADUser.DistinguishedName -TargetPath $DisabledOU #distinguishedName is the full unique path in AD
        Write-Log "Moved - $($User.SamAccountName) moved to Disabled Users OU."
    } Catch {
        Write-Log "Error - Could not move $($User.SamAccountName). Reason: $_"
    }
}

Write-Log "Offboarding run complete."
