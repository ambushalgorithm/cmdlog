# E2E Tests for cmdlog

This directory contains end-to-end Docker tests for cmdlog.

## Prerequisites

- Docker installed
- docker-compose (optional)

## Running Tests

```bash
# Build the test container
docker build -t cmdlog-e2e -f Dockerfile.e2e .

# Run all tests
docker run --rm cmdlog-e2e

# Run specific test
docker run --rm cmdlog-e2e test_audit_capture
```

## Test Cases

### 1. Audit Log Capture
Verifies that executed commands are captured in audit logs.

### 2. Filter Exclusion
Verifies that filtered commands are properly excluded from output.

### 3. Config File Loading
Verifies that config file is read correctly.

### 4. CLI Flag Override
Verifies that CLI flags override config settings.

### 5. Real-time Monitoring
Verifies --live mode works correctly.

## Architecture

The E2E tests spin up a container with:
- Ubuntu base
- auditd installed and configured
- cmdlog installed
- Test scripts that verify functionality
