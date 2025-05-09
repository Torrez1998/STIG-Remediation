<#
.SYNOPSIS
    This Bash script ensures that the Ubuntu 22.04 LTS SSH daemon prevents remote hosts from connecting to the proxy display.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-13-2025
    Last Modified   : 04-13-2025 
    Version         : 1.0
    STIG-ID         : UBTU-22-255045

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Ubuntu 22.04 LTS
    Bash Version    :   

.USAGE
    Run the script with root privileges to apply the remediation.
    Example syntax:
    $ sudo ./UBTU-22-255045.sh 
#>

#!/bin/bash

CONFIG_FILE="/etc/ssh/sshd_config"
SETTING="X11UseLocalhost yes"

# Function to check if the setting exists and is correctly configured
check_x11uselocalhost() {
    grep -E "^X11UseLocalhost" "$CONFIG_FILE" | grep -q "yes"
    return $?
}

# Apply the fix if necessary
if check_x11uselocalhost; then
    echo "Compliance check passed: X11UseLocalhost is correctly set to 'yes'. No changes needed."
else
    echo "Remediating: Ensuring X11UseLocalhost is set to 'yes'..."

    # Ensure no conflicting or commented-out entries exist
    sed -i '/^X11UseLocalhost/d' "$CONFIG_FILE"

    # Append the correct configuration at the end of the file
    echo "$SETTING" >> "$CONFIG_FILE"

    # Restart SSH service for changes to take effect
    systemctl restart sshd.service

    echo "Remediation complete: X11UseLocalhost set to 'yes' and SSHD restarted."
fi
