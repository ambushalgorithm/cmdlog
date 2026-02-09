# cmdlog - Clawdbot Command Audit Viewer

View all commands executed by the clawdbot user via Linux auditd logs.

## Quick Start

```bash
# Show all of today's commands
cmdlog

# Last 200 commands only
cmdlog-recent

# Search for specific commands
cmdlog-grep "git push"

# Watch live as commands are executed
cmdlog-live

# Raw audit format for debugging
cmdlog --raw 50
```

## Commands

| Command | Description | Default Limit |
|---------|-------------|---------------|
| `cmdlog` | All of today's commands | No limit |
| `cmdlog --recent 50` | Last N commands | 200 |
| `cmdlog --today 100` | Today's commands, limited | No limit |
| `cmdlog --grep "pattern"` | Search commands | No limit |
| `cmdlog --live` | Real-time watch | N/A |
| `cmdlog --raw` | Raw audit entries | No limit |

## Installation

1. **Clone/setup:**
   ```bash
   git clone <repo> ~/Projects/cmdlog
   cd ~/Projects/cmdlog
   chmod +x cmdlog
   ```

2. **Add to PATH:**
   ```bash
   # Add to ~/.bashrc
   export PATH="$HOME/Projects/cmdlog:$PATH"
   ```

3. **Or source aliases:**
   ```bash
   # Add to ~/.bashrc
   source ~/Projects/cmdlog/aliases.sh
   ```

## Requirements

- `auditd` installed and running
- Audit rule active: `-a always,exit -F arch=b64 -S execve -F uid=1001 -k clawdbot_exec`
- `sudo` access to read `/var/log/audit/audit.log`

## Timezone

Timestamps display in local timezone (configured to Bogota/UTC-5 in setup).

## License

MIT
