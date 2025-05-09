<#
.SYNOPSIS
    This Bash script ensures that Ubuntu 22.04 LTS prevents direct login into the root account.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-14-2025
    Last Modified   : 04-14-2025 
    Version         : 1.0
    STIG-ID         : UBTU-22-411010

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Ubuntu 22.04 LTS
    Bash Version    :   

.USAGE
    Run the script with root privileges to apply the remediation.
    Example syntax:
    $ sudo ./UBTU-22-411010.sh 
#>

#!/bin/bash

# Check the current status of the root account
ROOT_STATUS=$(sudo passwd -S root | awk '{print $2}')

# If the root account is not locked, lock it
if [ "$ROOT_STATUS" != "L" ]; then
    echo "Locking the root account to prevent direct logins..."
    sudo passwd -l root
    echo "Root account has been locked."
else
    echo "Root account is already locked. No changes needed."
fi

# Verify the change
echo "Verifying root account status..."
sudo passwd -S root
