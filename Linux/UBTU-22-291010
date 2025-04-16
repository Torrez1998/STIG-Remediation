<#
.SYNOPSIS
    This Bash script ensures that Ubuntu 22.04 LTS disables the automatic mounting of USB mass storage devices by preventing the loading of the USB storage kernel module.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-15-2025
    Last Modified   : 04-15-2025 
    Version         : 1.0
    STIG-ID         : UBTU-22-291010

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Ubuntu 22.04 LTS
    Bash Version    :   

.USAGE
    Run the script with root privileges to apply the remediation.
    Example syntax:
    $ sudo ./UBTU-22-291010.sh 
#>

#!/bin/bash

MODPROBE_FILE="/etc/modprobe.d/stig.conf"

# Ensure the modprobe.d directory exists
if [ ! -d "/etc/modprobe.d" ]; then
    echo "Error: /etc/modprobe.d directory does not exist. Exiting."
    exit 1
fi

# Backup existing stig.conf before modifying
if [ -f "$MODPROBE_FILE" ]; then
    echo "Backing up existing $MODPROBE_FILE..."
    sudo cp "$MODPROBE_FILE" "$MODPROBE_FILE.bak_$(date +%F_%H-%M-%S)"
fi

# Ensure usb-storage is disabled
if ! sudo grep --fixed-strings --quiet -- "install usb-storage /bin/false" "$MODPROBE_FILE"; then
    echo "Disabling USB mass storage module..."
    echo "install usb-storage /bin/false" | sudo tee -a "$MODPROBE_FILE"
else
    echo "USB storage module is already disabled."
fi

# Ensure usb-storage is blacklisted
if ! sudo grep --fixed-strings --quiet -- "blacklist usb-storage" "$MODPROBE_FILE"; then
    echo "Blacklisting USB mass storage..."
    echo "blacklist usb-storage" | sudo tee -a "$MODPROBE_FILE"
else
    echo "USB storage is already blacklisted."
fi

# Verify changes
echo "Verifying configuration..."
grep usb-storage "$MODPROBE_FILE"

echo "Remediation complete: USB mass storage is now disabled."
