<#
.SYNOPSIS
    This PowerShell script enables audit policy subcategory settings by modifying the registry to enforce granular auditing controls.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-09-2025
    Last Modified   : 04-09-2025 
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000030

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. :   

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-SO-000030.ps1 
#>

# Create or modify the registry key for enabling audit policy subcategory settings
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Force

# Set the SCENoApplyLegacyAuditPolicy value to 1 (enable subcategory settings)
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" -Name "SCENoApplyLegacyAuditPolicy" -Value 1 -Type DWord

# Verify the setting
$registryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$valueName = "SCENoApplyLegacyAuditPolicy"

$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName
if ($currentValue -eq 1) {
    Write-Output "The registry value '$valueName' is correctly configured to enable audit policy subcategory settings (1)."
} else {
    Write-Output "The registry value '$valueName' is not correctly configured. Current value: $currentValue. Expected: 1."
}
