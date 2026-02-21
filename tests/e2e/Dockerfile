FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    auditd \
    bats \
    curl \
    wget \
    git \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create test user
RUN useradd -m -s /bin/bash testuser

# Copy cmdlog
COPY ../cmdlog /usr/local/bin/cmdlog
COPY ../filters.conf /usr/local/etc/cmdlog.filters.conf

# Copy test scripts
COPY tests/e2e/run_tests.sh /tests/run.sh
COPY tests/e2e/test_audit_capture.sh /tests/test_audit_capture.sh
COPY tests/e2e/test_filters.sh /tests/test_filters.sh
COPY tests/e2e/test_config.sh /tests/test_config.sh
COPY tests/e2e/test_cli_flags.sh /tests/test_cli_flags.sh

RUN chmod +x /tests/*.sh /usr/local/bin/cmdlog

WORKDIR /tests

# Start auditd and run tests
CMD ["/tests/run.sh"]
