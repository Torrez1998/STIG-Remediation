<#
.SYNOPSIS
    This Bash script ensures that Ubuntu 22.04 LTS generates audit records for all account creations, modifications, disabling, and termination events that affect "/etc/passwd".

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-14-2025
    Last Modified   : 04-14-2025 
    Version         : 1.0
    STIG-ID         : UBTU-22-654145

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Ubuntu 22.04 LTS
    Bash Version    :   

.USAGE
    Run the script with root privileges to apply the remediation.
    Example syntax:
    $ sudo ./UBTU-22-654145.sh 
#>

#!/bin/bash

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"
AUDIT_RULE="-w /etc/passwd -p wa -k usergroup_modification"

# Ensure auditd is installed
if ! dpkg -l | grep -q auditd; then
    echo "Installing auditd..."
    sudo apt update && sudo apt install -y auditd
fi

# Ensure the rules file exists
if [ ! -f "$AUDIT_RULES_FILE" ]; then
    echo "Creating audit rules file: $AUDIT_RULES_FILE"
    touch "$AUDIT_RULES_FILE"
fi

# Check if the audit rule is already present
if grep -q -- "$AUDIT_RULE" "$AUDIT_RULES_FILE"; then
    echo "Audit rule already exists: $AUDIT_RULE"
else
    echo "Adding audit rule: $AUDIT_RULE"
    echo "$AUDIT_RULE" >> "$AUDIT_RULES_FILE"
fi

# Reload audit rules
echo "Reloading audit rules..."
sudo augenrules --load

# Verify the rule is active
echo "Verifying audit rule..."
sudo auditctl -l | grep passwd

echo "Remediation complete: Ubuntu now generates audit logs for /etc/passwd modifications."
