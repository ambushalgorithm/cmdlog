# cmdlog TODO

## Config System

- [x] Create config.sample with documented options
- [x] Add config file reading (~/.config/cmdlog.conf)
- [x] Add env var overrides (CMDLOG_AUDIT_KEY, CMDLOG_USER, CMDLOG_CONFIG)
- [x] Add CLI flags (--key, --user, --config)
- [x] Update help text to remove "openclaw" references
- [x] Add first-run "config not found" message with setup instructions
- [x] Update filter loading to use new config system
- [x] Update README with new setup instructions

## Testing

- [x] Set up test framework (bashunit, bats, or similar)
- [x] Write unit tests for config loading (env vars, config file, CLI precedence)
- [x] Write unit tests for filter matching logic
- [x] Write unit tests for command parsing (hex decode, proctitle extraction)
- [x] Set up e2e Docker container for integration testing
- [x] E2E test: verify audit logs are captured correctly
- [x] E2E test: verify filters correctly exclude commands
- [x] E2E test: verify config file loading
- [x] E2E test: verify CLI flags override config
- [x] Add CI workflow for automated testing
- [ ] Run E2E tests in Docker and fix any issues

## Future Ideas

- [ ] Agent detection (auto-detect which agent is running)
- [ ] Output formats (JSON, CSV, plain text)
- [ ] Web UI for browsing logs
- [ ] Real-time streaming to a file/API
- [ ] Plugin system for custom output handlers
