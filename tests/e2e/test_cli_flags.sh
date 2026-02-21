#!/bin/bash
# E2E test: verify CLI flags are in help output

# Get help output directly and check
HELP=$(cmdlog --help 2>&1)

# Check each flag exists in help
PASS=0
FAIL=0

if echo "$HELP" | grep -q "\-k,"; then
    echo "✓ CLI flag -k: PASSED"
    ((PASS++))
else
    echo "✗ CLI flag -k: FAILED"
    ((FAIL++))
fi

if echo "$HELP" | grep -q "cmdlog --config"; then
    echo "✓ CLI flag --config: PASSED"
    ((PASS++))
else
    echo "✗ CLI flag --config: FAILED"
    ((FAIL++))
fi

if echo "$HELP" | grep -q "\-\-key"; then
    echo "✓ CLI flag --key: PASSED"
    ((PASS++))
else
    echo "✗ CLI flag --key: FAILED"
    ((FAIL++))
fi

if echo "$HELP" | grep -q "\-\-filters"; then
    echo "✓ CLI flag --filters: PASSED"
    ((PASS++))
else
    echo "✗ CLI flag --filters: FAILED"
    ((FAIL++))
fi

[ $FAIL -eq 0 ]
