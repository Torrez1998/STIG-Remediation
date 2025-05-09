<#
.SYNOPSIS
    This PowerShell script configures the system to prevent the automatic download of attachments from RSS feeds by modifying the registry settings.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-12-2025
    Last Modified   : 04-12-2025 
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000295

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. :   

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000295.ps1 
#>

# Create or modify the registry key for RSS feed attachments
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds" -Force

# Set the DisableEnclosureDownload value to 1 (prevent attachment downloads from RSS feeds)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds" -Name "DisableEnclosureDownload" -Value 1 -Type DWord

# Verify the setting
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds"
$valueName = "DisableEnclosureDownload"

$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName
if ($currentValue -eq 1) {
    Write-Output "Attachments from RSS feeds are correctly prevented from being downloaded."
} else {
    Write-Output "The registry value '$valueName' is not correctly configured. Current value: $currentValue. Expected: 1."
}
