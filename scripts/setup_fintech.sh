#!/bin/bash

# ==========================================
# Fintech Operations Environment Setup
# ==========================================

echo "Starting fintech_ops configuration..."

# 1. Create the fintech_ops group
sudo groupadd -f fintech_ops

# 2. Add the current user to the group
sudo usermod -aG fintech_ops "$USER"

# 3. Create shared deployment directory
sudo mkdir -p /opt/fintech-deployment

# 4. Set group ownership
sudo chown -R root:fintech_ops /opt/fintech-deployment

# 5. Set read-write-execute permissions
#    Setgid ensures new files inherit the fintech_ops group
sudo chmod 2775 /opt/fintech-deployment

# 6. Configure restricted sudo access
sudo tee /etc/sudoers.d/fintech_ops > /dev/null <<EOF
%fintech_ops ALL=(root) /usr/bin/systemctl start fintech-app.service, /usr/bin/systemctl stop fintech-app.service, /usr/bin/systemctl restart fintech-app.service, /usr/bin/systemctl status fintech-app.service
EOF

# 7. Validate sudo configuration
sudo visudo -c

echo ""
echo "===== Configuration Complete ====="
echo "Group:"
getent group fintech_ops

echo ""
echo "Deployment Directory:"
ls -ld /opt/fintech-deployment

echo ""
echo "Restricted Sudo Configuration:"
sudo cat /etc/sudoers.d/fintech_ops
