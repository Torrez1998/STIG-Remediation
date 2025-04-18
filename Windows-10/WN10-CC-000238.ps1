<#
.SYNOPSIS
    This PowerShell script ensures that Windows 10 must be configured to prevent certificate error overrides in Microsoft Edge.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-10-2025
    Last Modified   : 04-10-2025 
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000238

.TESTED ON 
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000238.ps1 
#>

# Define the registry path
$RegistryPath = "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\Internet Settings"

# Check if the path exists; if not, create it
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force
}

# Set the PreventCertErrorOverrides policy
Set-ItemProperty -Path $RegistryPath -Name "PreventCertErrorOverrides" -Value 1 -Type DWord

# Verify the configuration
Get-ItemProperty -Path $RegistryPath -Name "PreventCertErrorOverrides"
