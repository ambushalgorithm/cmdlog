# cmdlog Tests

This directory contains unit and end-to-end tests for cmdlog.

## Directory Structure

```
tests/
├── unit/           # Unit tests (bats)
│   ├── config.bats # Config loading tests
│   └── filters.bats# Filter matching tests
└── e2e/            # End-to-end Docker tests
    ├── Dockerfile
    ├── README.md
    ├── run_tests.sh
    ├── test_audit_capture.sh
    ├── test_filters.sh
    ├── test_config.sh
    └── test_cli_flags.sh
```

## Running Tests

### Unit Tests

```bash
# Install bats
sudo apt-get install bats

# Run all unit tests
bats tests/unit/

# Run specific test file
bats tests/unit/config.bats
```

### E2E Tests

```bash
# Build and run Docker tests
docker build -t cmdlog-e2e -f tests/e2e/Dockerfile .
docker run --rm cmdlog-e2e
```

### CI

Tests run automatically on GitHub Actions. See `.github/workflows/tests.yml`.
