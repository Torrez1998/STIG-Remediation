<#
.SYNOPSIS
    This Bash script ensures that Ubuntu 22.04 LTS enforces password complexity by requiring at least one lowercase character.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-13-2025
    Last Modified   : 04-13-2025 
    Version         : 1.0
    STIG-ID         : UBTU-22-611015

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Ubuntu 22.04 LTS
    Bash Version    :   

.USAGE
    Run the script with root privileges to apply the remediation.
    Example syntax:
    $ sudo ./UBTU-22-611015.sh 
#>

#!/bin/bash

CONFIG_FILE="/etc/security/pwquality.conf"
SETTING="lcredit = -1"

# Ensure the required package is installed
if ! dpkg -l | grep -q libpam-pwquality; then
    echo "Installing libpam-pwquality..."
    sudo apt update && sudo apt install -y libpam-pwquality
fi

# Ensure the configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Creating $CONFIG_FILE..."
    touch "$CONFIG_FILE"
fi

# Check if the setting exists and update it
if grep -q "^lcredit" "$CONFIG_FILE"; then
    sed -i 's/^lcredit.*/lcredit = -1/' "$CONFIG_FILE"
else
    echo "$SETTING" >> "$CONFIG_FILE"
fi

echo "Remediation complete: Password complexity now requires at least one lowercase character."

# Verify the setting
grep -i lcredit "$CONFIG_FILE"
