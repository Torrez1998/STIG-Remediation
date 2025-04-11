<#
.SYNOPSIS
    This PowerShell script configures the lock screen camera policy by modifying the registry to disable camera access from the Windows lock screen.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-09-2025
    Last Modified   : 04-09-2025 
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. :   

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000005.ps1 
#>

#Create or modify the registry key for the lock screen camera policy
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Force

# Set the NoLockScreenCamera value to 1 (disable camera access from the lock screen)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreenCamera" -Value 1 -Type DWord

# Verify the setting
$currentValue = Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization" -Name "NoLockScreenCamera" | Select-Object -ExpandProperty NoLockScreenCamera
if ($currentValue -eq 1) {
    Write-Output "The registry value has been successfully configured to disable the lock screen camera."
} else {
    Write-Output "Failed to configure the registry value. Please check permissions or registry path."
}
