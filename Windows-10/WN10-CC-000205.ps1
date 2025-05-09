<#
.SYNOPSIS
    This PowerShell script configures the Windows Telemetry setting by modifying the registry to enforce Security (0) or Basic (1) data collection levels.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-12-2025
    Last Modified   : 04-12-2025 
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000205

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. :   

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000205.ps1 
#>

# Create or modify the registry key for the Windows Telemetry setting
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Force

# Set the AllowTelemetry value to 0 (Security) or 1 (Basic) to comply with the STIG
# Change the value to 2 (Enhanced) only if explicitly required for Windows Analytics
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0 -Type DWord

# Verify the setting
$currentValue = Get-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" | Select-Object -ExpandProperty AllowTelemetry
if ($currentValue -eq 0) {
    Write-Output "The registry value has been successfully configured to Security (0)."
} elseif ($currentValue -eq 1) {
    Write-Output "The registry value has been successfully configured to Basic (1)."
} elseif ($currentValue -eq 2) {
    Write-Output "The registry value has been successfully configured to Enhanced (2). Ensure this setting complies with V-220833."
} else {
    Write-Output "Failed to configure the registry value. Current value: $currentValue. Please check permissions or registry path."
}
