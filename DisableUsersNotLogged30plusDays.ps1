# Import the Active Directory module
Import-Module ActiveDirectory

# Get the current date and time
$currentDateTime = Get-Date

# Calculate the date 30 days ago
$thresholdDate = $currentDateTime.AddDays(-30)

# Retrieve user accounts that have not logged on since the threshold date
$usersToDisable = Get-ADUser -Filter {Enabled -eq $true -and LastLogonDate -le $thresholdDate} -Properties LastLogonDate

# Disable the user accounts
foreach ($user in $usersToDisable) {
    Disable-ADAccount -Identity $user.SamAccountName
    Write-Host "User account '$($user.SamAccountName)' has been disabled due to inactivity."
}
