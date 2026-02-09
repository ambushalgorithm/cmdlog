# cmdlog - Clawdbot Command Audit Viewer

View all commands executed by the clawdbot user via Linux auditd logs.

## Quick Start

```bash
# Last 1000 commands (fast - under 1 second)
cmdlog

# Last 50 only
cmdlog 50

# All of today's commands (slow with many entries)
cmdlog --all

# Search for commands
cmdlog --grep git

# Raw audit format
cmdlog --raw 100

# Watch live
cmdlog --live
```

## Commands

| Command | Description | Speed |
|---------|-------------|-------|
| `cmdlog [N]` | Last N commands (default 1000) | ⚡ Fast |
| `cmdlog --all` | All of today's commands | 🐢 Slow |
| `cmdlog --grep pattern` | Search recent commands | ⚡ Fast |
| `cmdlog --live` | Real-time watch | ⚡ Fast |
| `cmdlog --raw [N]` | Raw audit entries | ⚡ Fast |

## Aliases

Add to `~/.bashrc`:
```bash
source ~/Projects/cmdlog/aliases.sh
```

Then use:
```bash
cmdlog-recent   # = cmdlog --recent 200
cmdlog-today    # = cmdlog --today
cmdlog-grep     # = cmdlog --grep
cmdlog-live     # = cmdlog --live
cmdlog-raw      # = cmdlog --raw
```

## Installation

Already set up at `~/Projects/cmdlog/`. Just ensure PATH includes it:
```bash
export PATH="$HOME/Projects/cmdlog:$PATH"
```

## Requirements

- `auditd` running with rule for clawdbot (UID 1001)
- `sudo` access to read audit logs

## What's Shown

Commands are filtered to show:
- ✅ Real commands (git, python, your tools)
- ✅ bash/sh commands with actual content
- ❌ Utilities (grep, tail, awk, date, etc.)
- ❌ Empty shells (bare `bash -c` with no command)
- ❌ cmdlog's own pipeline

## Performance

The script uses **awk for all processing** (no per-line bash commands):
- 1000 entries: ~0.4 seconds
- 10,000 entries: ~2 seconds  
- All 195k entries: ~30 seconds (use `--all` sparingly)

## Timezone

Timestamps in local time (Bogota/UTC-5).

## Repo Location

`~/Projects/cmdlog/` - Track your own changes with git.
