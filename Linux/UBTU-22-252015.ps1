<#
.SYNOPSIS
    This Bash script ensures that Ubuntu 22.04 LTS synchronizes internal information system clocks to the authoritative time source when the time difference is greater than one second.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-14-2025
    Last Modified   : 04-14-2025 
    Version         : 1.0
    STIG-ID         : UBTU-22-252015

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Ubuntu 22.04 LTS
    Bash Version    :   

.USAGE
    Run the script with root privileges to apply the remediation.
    Example syntax:
    $ sudo ./UBTU-22-252015.sh 
#>

#!/bin/bash

CONFIG_FILE="/etc/chrony/chrony.conf"
NTP_SERVERS=("pool 0.ubuntu.pool.ntp.org iburst" "pool time.google.com iburst")

# Ensure chrony is installed
if ! dpkg -l | grep -q chrony; then
    echo "Installing chrony..."
    sudo apt update && sudo apt install -y chrony
fi

# Ensure the configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Configuration file not found. Creating $CONFIG_FILE..."
    touch "$CONFIG_FILE"
fi

# Remove PHC0 (local hardware clock) if present
if grep -q "PHC0" "$CONFIG_FILE"; then
    echo "Removing PHC0 from chrony configuration..."
    sed -i '/PHC0/d' "$CONFIG_FILE"
fi

# Ensure makestep setting exists and is correct
if grep -q "^makestep" "$CONFIG_FILE"; then
    sed -i 's/^makestep.*/makestep 1 1/' "$CONFIG_FILE"
else
    echo "makestep 1 1" >> "$CONFIG_FILE"
fi

# Remove all existing NTP servers (prevents conflicts)
sed -i '/^pool /d' "$CONFIG_FILE"

# Add external NTP servers
for server in "${NTP_SERVERS[@]}"; do
    echo "Adding NTP server: $server"
    echo "$server" >> "$CONFIG_FILE"
done

# Restart the chrony service to apply changes
echo "Restarting Chrony service..."
sudo systemc
