<#
.SYNOPSIS
    This Bash script ensures that Ubuntu 22.04 LTS requires users to reauthenticate for privilege escalation or when changing roles.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-13-2025
    Last Modified   : 04-13-2025 
    Version         : 1.0
    STIG-ID         : UBTU-22-432010

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Ubuntu 22.04 LTS
    Bash Version    :   

.USAGE
    Run the script with root privileges to apply the remediation.
    Example syntax:
    $ sudo ./UBTU-22-432010.sh 
#>

#!/bin/bash

# Define sudoers files
SUDOERS_MAIN="/etc/sudoers"
SUDOERS_DIR="/etc/sudoers.d"

# Function to remove occurrences of "NOPASSWD" or "!authenticate"
remove_insecure_entries() {
    local file="$1"
    if sudo grep -i 'nopasswd\|!authenticate' "$file" >/dev/null 2>&1; then
        echo "Removing insecure sudo permissions in: $file"
        sudo sed -i -E '/(NOPASSWD|!authenticate)/d' "$file"
    fi
}

# Ensure no "NOPASSWD" or "!authenticate" exists in /etc/sudoers
remove_insecure_entries "$SUDOERS_MAIN"

# Ensure no "NOPASSWD" or "!authenticate" exists in /etc/sudoers.d/*
if [ -d "$SUDOERS_DIR" ] && [ "$(ls -A "$SUDOERS_DIR")" ]; then
    for sudo_file in "$SUDOERS_DIR"/*; do
        [ -f "$sudo_file" ] && remove_insecure_entries "$sudo_file"
    done
else
    echo "No files found in /etc/sudoers.d/ to check."
fi

# Verify the fix
echo "Verifying sudoers configuration..."
if [ -d "$SUDOERS_DIR" ] && [ "$(ls -A "$SUDOERS_DIR")" ]; then
    sudo find "$SUDOERS_DIR" -type f -exec grep -i 'nopasswd\|!authenticate' {} + || echo "No insecure sudo permissions found."
else
    sudo grep -i 'nopasswd\|!authenticate' "$SUDOERS_MAIN" || echo "No insecure sudo permissions found."
fi

echo "Remediation complete: Users must now reauthenticate for privilege escalation."
