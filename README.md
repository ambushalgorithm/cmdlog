# cmdlog - Clawdbot Command Audit Viewer

View all commands executed by the clawdbot user via Linux auditd logs.

## Quick Start

```bash
# Show all of today's commands (may be slow on busy days)
cmdlog

# Last 200 commands (fast)
cmdlog-recent

# Last 50 commands
cmdlog --recent 50

# Search for specific commands (searches last 10 min, max 500 results)
cmdlog --grep "git commit"

# Raw audit format
cmdlog --raw 100

# Watch live as commands are executed
cmdlog --live
```

## Commands

| Command | Description | Notes |
|---------|-------------|-------|
| `cmdlog` | All of today's commands | No limit; may be slow with many entries |
| `cmdlog --recent N` | Last N commands (default 200) | Fast - uses tail approach |
| `cmdlog --today N` | Today's commands, limited to N | Same as --recent |
| `cmdlog --grep pattern` | Search recent commands | Searches last 10 min, up to 500 matches |
| `cmdlog --live` | Real-time watch | Shows new commands as they happen |
| `cmdlog --raw N` | Raw audit entries | Skip formatting, show raw logs |
| `cmdlog --help` | Show help | |

## Aliases

For convenience, these aliases are available (defined in `aliases.sh`):

```bash
cmdlog-recent   # = cmdlog --recent 200
cmdlog-today    # = cmdlog --today
cmdlog-grep     # = cmdlog --grep
cmdlog-live     # = cmdlog --live
cmdlog-raw      # = cmdlog --raw
```

## Installation

1. **Add to PATH** (in `~/.bashrc`):
   ```bash
   export PATH="$HOME/Projects/cmdlog:$PATH"
   source ~/Projects/cmdlog/aliases.sh
   ```

2. **Reload shell**:
   ```bash
   source ~/.bashrc
   ```

## Requirements

- `auditd` installed and running
- Audit rule active for clawdbot user (UID 1001):
  ```
  -a always,exit -F arch=b64 -S execve -F uid=1001 -k clawdbot_exec
  ```
- `sudo` access to read audit logs

## Timezone

Timestamps display in local timezone (default: America/Bogota, UTC-5).

## Performance Notes

- `--recent` and `--today` with limits are **fast** (sub-second)
- `cmdlog` without limits may take 10-30 seconds on busy days
- `--grep` searches only the last 10 minutes for speed
- `--live` has minimal overhead (< 1% CPU)

## Internal Commands Filtered

The following are automatically hidden:
- Pipeline tools: `grep`, `tail`, `awk`, `sed`, etc.
- System: `sudo`, `bash`, `sh`, `ip`, `node`
- Helpers: `python3`, `jq`, `flock`, `env`
- Self-references: any command containing `cmdlog`

## Location

- Repo: `~/Projects/cmdlog/`
- Main script: `~/Projects/cmdlog/cmdlog`
- Aliases: `~/Projects/cmdlog/aliases.sh`

## License

MIT
