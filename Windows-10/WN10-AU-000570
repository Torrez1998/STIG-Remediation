<#
.SYNOPSIS
    This PowerShell script ensures that the password history must be configured to 24 passwords remembered.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-10-2025
    Last Modified   : 04-10-2025 
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000570

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-AU-000570.ps1 
#>

Write-Host "Enabling advanced audit policy subcategory settings override..."
auditpol /set /category:"Object Access" /subcategory:"Detailed File Share" /failure:enable

# Verify the applied setting
Write-Host "Verifying applied audit settings..."
auditpol /get /subcategory:"Detailed File Share"
