<#
.SYNOPSIS
    This Bash script ensures that the Advance Package Tool (APT) is configured to prevent the installation of unauthorized packages by verifying their digital signatures.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-13-2025
    Last Modified   : 04-13-2025 
    Version         : 1.0
    STIG-ID         : UBTU-22-214010

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Ubuntu 22.04 LTS
    Bash Version    :   

.USAGE
    Run the script with root privileges to apply the remediation.
    Example syntax:
    $ sudo ./UBTU-22-214010.sh 
#>

#!/bin/bash

CONFIG_FILE="/etc/apt/apt.conf.d/00-stig-allowunauthenticated"

# Ensure the configuration file exists and contains the correct setting
echo 'APT::Get::AllowUnauthenticated "false";' | tee "$CONFIG_FILE" > /dev/null

echo "Remediation complete: APT is now configured to prevent unauthorized package installations."

# Verify the setting
grep -i allowunauthenticated /etc/apt/apt.conf.d/*
