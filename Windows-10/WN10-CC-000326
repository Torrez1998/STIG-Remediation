<#
.SYNOPSIS 
    This PowerShell script enables PowerShell Script Block Logging by modifying the registry settings to enhance security monitoring.

.NOTES
  Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-12-2025
    Last Modified   : 04-12-2025 
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000326

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. :   

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000326.ps1 
#>

# Create or modify the registry key for PowerShell script block logging
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Force

# Set the EnableScriptBlockLogging value to 1 (Enabled)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging" -Name "EnableScriptBlockLogging" -Value 1 -Type DWord

# Verify the setting
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"
$valueName = "EnableScriptBlockLogging"

$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName

if ($currentValue -eq 1) {
    Write-Output "PowerShell Script Block Logging is correctly enabled."
} else {
    Write-Output "PowerShell Script Block Logging is not enabled. Current value: $currentValue. Expected: 1."
}
