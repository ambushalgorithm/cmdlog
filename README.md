# openclaw-cmdlog

View your OpenClaw agent's shell commands from Linux audit logs. Tracks everything the AI runs so you can review, search, and audit its activity.

## Quick Start

```bash
# Add to PATH
export PATH="$HOME/.local/bin:$PATH"

# Last 1000 commands (fast)
openclaw-cmdlog

# Search for specific commands
openclaw-cmdlog --search git

# Watch live as commands execute
openclaw-cmdlog --live
```

## Prerequisites

**auditd** must be running with a rule tracking your OpenClaw user.

First, find your OpenClaw username:

```bash
# Get the user running OpenClaw (usually clawdbot or similar)
ps aux | grep openclaw | grep -v grep
# Or check: whoami (if running locally)
```

Then add the audit rule (replace `clawdbot` with your username):

```bash
# One-time setup (requires sudo)
sudo auditctl -a always,exit -F arch=b64 -S execve -F uid=$(id -u clawdbot) -k clawdbot_exec
```

To persist across reboots, add to `/etc/audit/rules.d/openclaw.rules`.

## Commands

| Command | Description | Speed |
|---------|-------------|-------|
| `openclaw-cmdlog [N]` | Last N commands (default 1000) | ⚡ Fast |
| `openclaw-cmdlog --all` | All of today's commands | 🐢 Slow |
| `openclaw-cmdlog --today [N]` | Today's commands (default 1000) | ⚡ Fast |
| `openclaw-cmdlog --recent [N]` | Last N commands (default 200) | ⚡ Fast |
| `openclaw-cmdlog --search <pattern>` | Search recent commands | ⚡ Fast |
| `openclaw-cmdlog --live` | Real-time watch | ⚡ Fast |
| `openclaw-cmdlog --raw [N]` | Raw audit entries | ⚡ Fast |

## Aliases (Optional)

Source the aliases file in your shell:

```bash
# Add to ~/.bashrc or ~/.zshrc
source /path/to/openclaw-cmdlog/aliases.sh
```

Then use:

```bash
openclaw-cmdlog-recent   # Last 200 commands
openclaw-cmdlog-today    # Today's commands
openclaw-cmdlog-search   # Search for pattern
openclaw-cmdlog-live     # Watch live
openclaw-cmdlog-raw      # Raw audit format
```

Or manually add aliases to `~/.bashrc`:

```bash
alias openclaw-cmdlog-recent='openclaw-cmdlog --recent'
alias openclaw-cmdlog-today='openclaw-cmdlog --today'
alias openclaw-cmdlog-search='openclaw-cmdlog --search'
alias openclaw-cmdlog-live='openclaw-cmdlog --live'
alias openclaw-cmdlog-raw='openclaw-cmdlog --raw'
```

## Installation

```bash
git clone https://github.com/yourname/openclaw-cmdlog ~/.local/bin/openclaw-cmdlog
# Or any directory in your PATH
```

Make sure the directory is in your PATH:

```bash
export PATH="$HOME/.local/bin/openclaw-cmdlog:$PATH"
```

## What's Filtered

| ✅ Shown | ❌ Hidden |
|----------|-----------|
| Shell commands the AI runs | System utilities (grep, awk, date) |
| Git, python, your tools | Empty bash shells |
| Built-in commands | The openclaw-cmdlog tool itself |

## Performance

Processing uses **awk** (no per-line bash loops):
- 1000 entries: ~0.5 seconds
- 10,000 entries: ~2 seconds

## Configuration

| Environment Variable | Purpose |
|---------------------|---------|
| `TZ` | Timezone for timestamps (defaults to system timezone) |

Override example:

```bash
export TZ="America/New_York"
openclaw-cmdlog
```

## Requirements

- Linux with `auditd` installed and running
- `sudo` access to read audit logs
- `auditctl` to configure rules
