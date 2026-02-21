#!/bin/bash
# E2E test: verify audit logs are captured correctly

# Check if auditd is running
if ! service auditd status >/dev/null 2>&1; then
    echo "⊘ Test skipped (auditd not running)"
    exit 0
fi

set -e

AUDIT_KEY="test_exec"
TEST_CMD="echo 'hello world'"

# Add audit rule
auditctl -w /bin/echo -p x -k "$AUDIT_KEY" 2>/dev/null || true

# Execute test command
$TEST_CMD

# Wait for audit log
sleep 1

# Check if command was logged
RESULT=$(ausearch -k "$AUDIT_KEY" -ts recent | grep -c "echo" || true)

if [ "$RESULT" -gt 0 ]; then
    echo "✓ Audit log capture: PASSED"
    exit 0
else
    echo "✗ Audit log capture: FAILED"
    exit 1
fi
