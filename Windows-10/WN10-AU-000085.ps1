<#
.SYNOPSIS
    This PowerShell script ensures that the system must be configured to audit Object Access - Removable Storage failures.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-10-2025
    Last Modified   : 04-10-2025 
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000085

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-AU-000085.ps1 
#>

# Ensure advanced audit policy subcategory settings override standard audit policy
$AuditPolicyKey = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$AuditPolicyValue = "SCENoApplyLegacyAuditPolicy"

if ((Get-ItemProperty -Path $AuditPolicyKey -Name $AuditPolicyValue -ErrorAction SilentlyContinue).$AuditPolicyValue -ne 1) {
    Write-Host "Enabling advanced audit policy subcategory settings override..."
    Set-ItemProperty -Path $AuditPolicyKey -Name $AuditPolicyValue -Value 1
}

# Apply audit policy for Removable Storage failures
Write-Host "Applying audit policy for Removable Storage failures..."
Start-Process -NoNewWindow -FilePath "auditpol.exe" -ArgumentList "/set /subcategory:`"Removable Storage`" /failure:enable" -Wait

# Force update security policies
Write-Host "Refreshing Group Policy..."
gpupdate /force

# Verify applied settings
Write-Host "Verifying applied audit settings..."
Start-Process -NoNewWindow -FilePath "auditpol.exe" -ArgumentList "/get /subcategory:`"Removable Storage`"" -Wait
