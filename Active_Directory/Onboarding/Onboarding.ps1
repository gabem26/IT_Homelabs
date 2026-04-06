#Onboarding Script

# Configuration block
# Write-Log function
# Import CSV
# ForEach loop
    # Generate username
    # Generate password
    # Check if user exists
    # Get manager object
    # Try: Create AD account
    # Catch: Log error
    # Try: Add to group
    # Catch: Log error
# End ForEach
# Log completion

#Config
$CsvPath    = "C:\Scripts\Onboarding\new_hires.csv"
$NewHiresOU = "OU=New Hires,OU=LAB Users,DC=LAB,DC=local" #where new accs will land
$Domain     = "LAB.local"
$LogPath    = "C:\Scripts\Onboarding\onboarding_log.txt"

#Logging func -- log to file and print to screen as well -- auditing purposes
Function Write-Log 
{
    Param([string]$Message)
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Entry     = "$Timestamp - $Message"
    Write-Host $Entry
    Add-Content -Path $LogPath -Value $Entry
}

#Import CSV
$NewHires = Import-Csv -Path $CsvPath #loads all rows in the new_hires.csv into $NewHires as a collection of objects that will be looped
Write-Log "Starting onboarding run. $($NewHires.Count) user(s) found in CSV."

#loop
ForEach ($User in $NewHires)
{
    #format: first initial + last name 
    $Username = ($User.FirstName[0] + $User.LastName).ToLower()
    #generate password
    $Password = ConvertTo-SecureString "Password1!" -AsPlainText -Force

    #check if user already exists
    If (Get-ADUser -Filter {SamAccountName -eq $Username} -ErrorAction SilentlyContinue)
    {
        Write-Log "Skipped - $Username already exists in AD."
        Continue
    }
    #get manager object
    $ManagerName = $User.Manager
    #pulling User.Manager into its own plain var before passing it into the filter block
    $Manager = Get-ADUser -Filter {SamAccountName -eq $ManagerName} -ErrorAction SilentlyContinue
    #create AD acc
    Try {
        $UserParams = @{
            Name              = "$($User.FirstName) $($User.LastName)"
            SamAccountName    = $Username
            UserPrincipalName = "$Username@$Domain"
            GivenName         = $User.FirstName
            Surname           = $User.LastName
            DisplayName       = "$($User.FirstName) $($User.LastName)"
            Title             = $User.JobTitle
            Department        = $User.Department
            Manager           = $Manager
            Path              = $NewHiresOU
            AccountPassword   = $Password
            Enabled           = $true
            ChangePasswordAtLogon = $true
            PasswordNeverExpires = $false 
        }
        New-ADUser @UserParams
        Write-Log "CREATED - $Username ($($User.FirstName) $($User.LastName))"
    } Catch {
        Write-Log "ERROR - Failed to create $Username. Reason: $_"
        Continue
    }
    Try {
        Add-ADGroupMember -Identity $User.Department -Members $Username #adds the new user to their department group
        Write-Log "Group - $Username added to $($User.Department) group."
    } Catch {
        Write-Log "Error - Could not add $Username to $($User.Department) group. Reason: $_"
    }
}

Write-Log "Onboarding run complete."