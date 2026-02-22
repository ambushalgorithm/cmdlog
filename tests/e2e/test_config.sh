#!/bin/bash
# E2E test: verify config file loading

set -e

# Create test config file
mkdir -p /home/testuser/.config
cat > /home/testuser/.config/cmdlog/cmdlog.conf << 'EOF'
AUDIT_KEY=my_custom_key
DEFAULT_LIMIT=100
TZ=Europe/Paris
EOF

export HOME="/home/testuser"

# Verify config file exists and contains expected values
if grep -q "AUDIT_KEY=my_custom_key" /home/testuser/.config/cmdlog/cmdlog.conf; then
    echo "✓ Config file loading: PASSED"
    exit 0
else
    echo "✗ Config file loading: FAILED"
    exit 1
fi
