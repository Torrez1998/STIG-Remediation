<#
.SYNOPSIS 
   This PowerShell script configures the ECC curve order for SSL by modifying the registry to prioritize NistP384 and NistP256 curves.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-09-2025
    Last Modified   : 04-09-2025
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000052

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. :   

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000052.ps1 
#>

# Create or modify the registry key for ECC curve order
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002" -Force

# Set the EccCurves value as REG_MULTI_SZ
$eccCurvesValue = @("NistP384", "NistP256")

# Use New-ItemProperty to set the value as REG_MULTI_SZ
New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002" -Name "EccCurves" -Value $eccCurvesValue -PropertyType MultiString -Force

# Verify the setting
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"
$valueName = "EccCurves"

$currentValue = Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty $valueName

# Normalize both current value and expected value by sorting the list and joining them into a single string for comparison
$normalizedCurrentValue = [string]::Join(" ", $currentValue)
$expectedValue = "NistP384 NistP256"

if ($normalizedCurrentValue -eq $expectedValue) {
    Write-Output "The registry value '$valueName' is correctly configured to prioritize ECC curves (NistP384, NistP256)."
} else {
    Write-Output "The registry value '$valueName' is not correctly configured. Current value: $normalizedCurrentValue. Expected: NistP384 NistP256."
}
