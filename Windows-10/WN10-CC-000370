<#
.SYNOPSIS 
    This PowerShell script disables convenience PIN sign-in for domain users by modifying the registry settings.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-11-2025
    Last Modified   : 04-11-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000370

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. :   

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000370.ps1 
#>

# Create or modify the registry key for domain PIN logon
New-Item -Path "HKLM:\Software\Policies\Microsoft\Windows\System" -Force

# Set the AllowDomainPINLogon value to 0 (disable convenience PIN sign-in for domain users)
Set-ItemProperty -Path "HKLM:\Software\Policies\Microsoft\Windows\System" -Name "AllowDomainPINLogon" -Value 0 -Type DWord

# Verify the setting
$registryPath = "HKLM:\Software\Policies\Microsoft\Windows\System"
$valueName = "AllowDomainPINLogon"

$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName
if ($currentValue -eq 0) {
    Write-Output "The registry value '$valueName' is correctly configured to disable convenience PIN sign-in (0)."
} else {
    Write-Output "The registry value '$valueName' is not correctly configured. Current value: $currentValue. Expected: 0."
}
