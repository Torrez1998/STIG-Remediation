<#
.SYNOPSIS
    This Bash script ensures that Ubuntu 22.04 LTS generates audit records when successful/unsuccessful attempts to modify the /etc/sudoers.d directory occur.

.NOTES
    Author          : Ariel Torres 
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-15-2025
    Last Modified   : 04-15-2025 
    Version         : 1.0
    STIG-ID         : UBTU-22-654225

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Ubuntu 22.04 LTS
    Bash Version    :   

.USAGE
    Run the script with root privileges to apply the remediation.
    Example syntax:
    $ sudo ./UBTU-22-654225.sh 
#>

#!/bin/bash

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"
RULE="-w /etc/sudoers.d -p wa -k privilege_modification"

# Ensure auditd is installed
if ! dpkg -l | grep -q auditd; then
    echo "Installing auditd..."
    sudo apt update && sudo apt install -y auditd
fi

# Ensure the audit rules file exists
if [ ! -e "$AUDIT_RULES_FILE" ]; then
    echo "Creating audit rules file: $AUDIT_RULES_FILE"
    sudo touch "$AUDIT_RULES_FILE"
    sudo chmod 640 "$AUDIT_RULES_FILE"
fi

# Add the rule if it does not exist
if ! sudo grep --fixed-strings --quiet -- "$RULE" "$AUDIT_RULES_FILE"; then
    echo "Adding audit rule for /etc/sudoers.d modifications..."
    echo "$RULE" | sudo tee -a "$AUDIT_RULES_FILE"
else
    echo "Audit rule for /etc/sudoers.d modifications already exists."
fi

# Reload audit rules
echo "Reloading audit rules..."
sudo augenrules --load

# Verify the rule is active
echo "Verifying applied audit rules..."
sudo auditctl -l | grep sudoers.d || echo "Warning: Rule not found in auditctl output!"

echo "Remediation complete: Ubuntu now generates audit logs for modifications to /etc/sudoers.d."
