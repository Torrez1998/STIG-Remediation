<#
.SYNOPSIS
    This PowerShell script configures the system to disable the Windows Inventory Collector by modifying the registry settings.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-11-2025
    Last Modified   : 04-11-2025 
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000175

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. :   

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000175.ps1 
#>

# Create or modify the registry key for disabling the Inventory Collector
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Force

# Set the DisableInventory value to 1 (turn off Inventory Collector)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableInventory" -Value 1 -Type DWord

# Verify the setting
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
$valueName = "DisableInventory"

$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName
if ($currentValue -eq 1) {
    Write-Output "The registry value '$valueName' is correctly configured to disable Inventory Collector (1)."
} else {
    Write-Output "The registry value '$valueName' is not correctly configured. Current value: $currentValue. Expected: 1."
}
