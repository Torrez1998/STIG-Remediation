<#
.SYNOPSIS
    This Bash script ensures that Ubuntu 22.04 LTS generates audit records for any use of the setxattr, fsetxattr, lsetxattr, removexattr, fremovexattr, and lremovexattr system calls.

.NOTES
    Author          : Ariel Torres
    LinkedIn        : https://www.linkedin.com/in/ariel-torrez/
    GitHub          : https://github.com/Torrez1998
    Date Created    : 04-15-2025
    Last Modified   : 04-15-2025 
    Version         : 1.0
    STIG-ID         : UBTU-22-654180

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : Ubuntu 22.04 LTS
    Bash Version    :   

.USAGE
    Run the script with root privileges to apply the remediation.
    Example syntax:
    $ sudo ./UBTU-22-654180.sh 
#>

#!/bin/bash

AUDIT_RULES_FILE="/etc/audit/rules.d/stig.rules"

RULES=(
    "-a always,exit -F arch=b32 -S setxattr,fsetxattr,lsetxattr,removexattr,fremovexattr,lremovexattr -F auid>=1000 -F auid!=-1 -k perm_mod"
    "-a always,exit -F arch=b32 -S setxattr,fsetxattr,lsetxattr,removexattr,fremovexattr,lremovexattr -F auid=0 -k perm_mod"
    "-a always,exit -F arch=b64 -S setxattr,fsetxattr,lsetxattr,removexattr,fremovexattr,lremovexattr -F auid>=1000 -F auid!=-1 -k perm_mod"
    "-a always,exit -F arch=b64 -S setxattr,fsetxattr,lsetxattr,removexattr,fremovexattr,lremovexattr -F auid=0 -k perm_mod"
)

# Ensure auditd is installed
if ! dpkg -l | grep -q auditd; then
    echo "Installing auditd..."
    sudo apt update && sudo apt install -y auditd
fi

# Ensure the audit rules file exists
if [ ! -f "$AUDIT_RULES_FILE" ]; then
    echo "Creating audit rules file: $AUDIT_RULES_FILE"
    touch "$AUDIT_RULES_FILE"
fi

# Add missing rules
for rule in "${RULES[@]}"; do
    if ! sudo grep --fixed-strings --quiet -- "$rule" "$AUDIT_RULES_FILE"; then
        echo "Adding rule: $rule"
        echo "$rule" >> "$AUDIT_RULES_FILE"
    else
        echo "Rule already exists: $rule"
    fi
done

# Reload audit rules
echo "Reloading audit rules..."
sudo augenrules --load

# Verify the rules
echo "Verifying applied audit rules..."
sudo auditctl -l | grep xattr

echo "Remediation complete: Ubuntu now generates audit logs for setxattr, fsetxattr, lsetxattr, removexattr, fremovexattr, and lremovexattr syscalls."
