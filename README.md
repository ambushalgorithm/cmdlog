# cmdlog

View your AI agent's shell commands from Linux audit logs. Tracks everything the AI runs so you can review, search, and audit its activity.

**Works with any AI agent** (OpenClaw, Claude Code, Codex, etc.)

## Quick Start

```bash
# Copy config and customize
cp config.sample ~/.config/cmdlog.conf

# Last 1000 commands (fast)
cmdlog

# Search for specific commands
cmdlog --search git

# Watch live as commands execute
cmdlog --live
```

## Prerequisites

**auditd** must be running with a rule tracking your agent's user.

First, find the user running your agent:

```bash
ps aux | grep -E "(openclaw|claude|codex)" | grep -v grep
```

Then add the audit rule (replace `clawdbot` with your username):

```bash
# One-time setup (requires sudo)
sudo auditctl -a always,exit -F arch=b64 -S execve -F uid=$(id -u clawdbot) -k clawdbot_exec
```

To persist across reboots, add to `/etc/audit/rules.d/cmdlog.rules`.

## Installation

```bash
# Clone anywhere
git clone https://github.com/crayon-doing-petri/openclaw-cmdlog.git

# Add to PATH
export PATH="$PATH:/path/to/openclaw-cmdlog"

# Or create symlink
ln -s /path/to/openclaw-cmdlog/cmdlog /usr/local/bin/cmdlog
```

First-run will prompt you to set up config.

## Commands

| Command | Description | Speed |
|---------|-------------|-------|
| `cmdlog [N]` | Last N commands (default 1000) | ⚡ Fast |
| `cmdlog --all` | All of today's commands | 🐢 Slow |
| `cmdlog --today [N]` | Today's commands (default 1000) | ⚡ Fast |
| `cmdlog --recent [N]` | Last N commands (default 200) | ⚡ Fast |
| `cmdlog --search <pattern>` | Search recent commands | ⚡ Fast |
| `cmdlog --live` | Real-time watch | ⚡ Fast |
| `cmdlog --raw [N]` | Raw audit entries | ⚡ Fast |
| `cmdlog --show-filters` | View filter patterns | ⚡ Fast |
| `cmdlog --config` | Show config locations | ⚡ Fast |

## Configuration

Config file: `~/.config/cmdlog.conf`  
Filters: `~/.config/cmdlog.filters.conf`

### Config Options

```bash
# ~/.config/cmdlog.conf
AUDIT_KEY="clawdbot_exec"      # Must match your auditd -k flag
DEFAULT_LIMIT=1000             # Default number of commands to show
TZ="America/Bogota"            # Timezone for timestamps
```

### Environment Variables

| Variable | Purpose | Default |
|----------|---------|---------|
| `CMDLOG_AUDIT_KEY` | Override audit key | From config |
| `CMDLOG_CONFIG_FILE` | Override config path | `~/.config/cmdlog.conf` |
| `CMDLOG_FILTERS_FILE` | Override filters path | `~/.config/cmdlog.filters.conf` |
| `CMDLOG_DEFAULT_LIMIT` | Default limit | 1000 |
| `CMDLOG_TZ` | Timezone | System default |
| `CMDLOG_POLL_INTERVAL` | Live poll seconds | 2 |

### CLI Flags

```
-k, --key <key>      Override audit key
-c, --config <file>  Override config file
-f, --filters <file> Override filters file
```

**Priority:** CLI flags > env vars > config file > defaults

## Custom Filters

Add filter patterns to hide specific commands:

```bash
# Create filters file
nano ~/.config/cmdlog.filters.conf
```

Example:
```
# Hide internal scripts
my-internal-script

# Hide cloud metadata probes
wget.*169\.254\.169\.254
curl.*metadata\.google\.internal

# Hide shell noise
^if\s+
^then$
^fi$
^exit\s+[0-9]+

# Hide nvm/node paths
\.nvm/versions
```

**Both filter files are merged:**
- `filters.conf` in script directory (defaults)
- `~/.config/cmdlog.filters.conf` (your filters)

View active filters:
```bash
cmdlog --show-filters
```

## Testing

```bash
# Unit tests
bats tests/unit/

# E2E tests (Docker)
docker build -t cmdlog-e2e -f tests/e2e/Dockerfile .
docker run --rm cmdlog-e2e
```

## Requirements

- Linux with `auditd` installed and running
- `sudo` access to read audit logs
- `auditctl` to configure rules

## License

MIT
