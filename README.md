# cmdlog

<p align="center">
  <strong>View your AI agent's shell commands from Linux audit logs</strong><br>
  Tracks everything the AI runs so you can review, search, and audit its activity.
</p>

<p align="center">
  <img src="https://img.shields.io/github/license/ambushalgorithm/openclaw-cmdlog" alt="License">
  <img src="https://img.shields.io/github/actions/workflow/status/ambushalgorithm/openclaw-cmdlog/tests.yml?label=Tests" alt="Tests">
</p>

---

**Works with any AI agent** — OpenClaw, Claude Code, Codex, Cursor, Roo, and more.

## ✨ Features

- 📋 **Command History** — View, search, and filter all commands your AI has run
- 🔍 **Pattern Search** — Quick search through recent commands
- 👀 **Live Watch** — Monitor commands in real-time as they execute
- 🎯 **Smart Filters** — Hide noise like cloud metadata probes, shell conditionals, nvm paths
- ⚙️ **Flexible Config** — Environment variables, config file, or CLI flags
- 🧪 **Tested** — Unit tests and E2E Docker tests included

---

## 🚀 Quick Start

```bash
# 1. Copy config and customize
cp config.sample ~/.config/cmdlog.conf

# 2. View recent commands
cmdlog

# 3. Search for specific commands
cmdlog --search git push

# 4. Watch live as commands execute
cmdlog --live
```

---

## 📋 Commands

| Command | Description | Example |
|---------|-------------|---------|
| `cmdlog` | Last 1000 commands | `cmdlog` |
| `cmdlog [N]` | Last N commands | `cmdlog 50` |
| `cmdlog --all` | All today's commands | `cmdlog --all` |
| `cmdlog --recent [N]` | Last N (default 200) | `cmdlog --recent 50` |
| `cmdlog --search <pattern>` | Search commands | `cmdlog --search "git push"` |
| `cmdlog --live` | Real-time watch | `cmdlog --live` |
| `cmdlog --raw [N]` | Raw audit entries | `cmdlog --raw` |
| `cmdlog --show-filters` | View active filters | `cmdlog --show-filters` |
| `cmdlog --config` | Show config paths | `cmdlog --config` |

---

## 🔧 Prerequisites

**auditd** must be running with a rule tracking your agent's user.

### 1. Find your agent's user

```bash
ps aux | grep -E "(openclaw|claude|codex)" | grep -v grep
```

### 2. Add audit rule

```bash
# Replace 'clawdbot' with your agent's username
sudo auditctl -a always,exit -F arch=b64 -S execve -F uid=$(id -u clawdbot) -k clawdbot_exec
```

To persist across reboots, add to `/etc/audit/rules.d/cmdlog.rules`:

```bash
# /etc/audit/rules.d/cmdlog.rules
-a always,exit -F arch=b64 -S execve -F uid=1000 -k clawdbot_exec
```

---

## 📦 Installation

```bash
# Clone anywhere
git clone https://github.com/ambushalgorithm/openclaw-cmdlog.git

# Add to PATH
export PATH="$PATH:/path/to/openclaw-cmdlog"

# Or symlink to /usr/local/bin
ln -s /path/to/openclaw-cmdlog/cmdlog /usr/local/bin/cmdlog
```

First-run will prompt you to copy `config.sample` to `~/.config/cmdlog.conf`.

---

## ⚙️ Configuration

**Config file:** `~/.config/cmdlog.conf`  
**Filters:** `~/.config/cmdlog.filters.conf`

### Config Options

```bash
# ~/.config/cmdlog.conf
AUDIT_KEY="clawdbot_exec"      # Must match your auditd -k flag
DEFAULT_LIMIT=1000             # Default number of commands to show
TZ="America/New_York"           # Timezone for timestamps
```

### Environment Variables

| Variable | Purpose | Default |
|----------|---------|---------|
| `CMDLOG_AUDIT_KEY` | Override audit key | From config |
| `CMDLOG_CONFIG_FILE` | Override config path | `~/.config/cmdlog.conf` |
| `CMDLOG_FILTERS_FILE` | Override filters path | `~/.config/cmdlog.filters.conf` |
| `CMDLOG_DEFAULT_LIMIT` | Default limit | `1000` |
| `CMDLOG_TZ` | Timezone | System default |
| `CMDLOG_POLL_INTERVAL` | Live poll interval (sec) | `2` |

### CLI Flags

```bash
-k, --key <key>      Override audit key
-c, --config <file>  Override config file
-f, --filters <file> Override filters file
```

**Priority:** CLI flags → env vars → config file → defaults

---

## 🧹 Custom Filters

Hide commands you don't want to see:

```bash
# ~/.config/cmdlog.filters.conf
# Add your patterns (one per line)

# Hide internal scripts
my-internal-script

# Hide cloud metadata probes
wget.*169\.254\.169\.254
curl.*metadata\.google\.internal

# Hide shell conditionals
^if\s+
^then$
^fi$
^exit\s+[0-9]+

# Hide nvm/node paths
\.nvm/versions
\.node_versions
```

**Filters are merged from:**
1. `filters.conf` in script directory (defaults)
2. `~/.config/cmdlog.filters.conf` (your custom)

View active filters:
```bash
cmdlog --show-filters
```

---

## 🧪 Testing

```bash
# Unit tests
bats tests/unit/

# E2E tests (Docker)
docker build -t cmdlog-e2e -f tests/e2e/Dockerfile .
docker run --rm cmdlog-e2e
```

---

## 📖 Requirements

- Linux with `auditd` installed and running
- `sudo` access to read audit logs
- `auditctl` to configure rules

---

## 🤝 Contributing

1. Fork the repo
2. Create a feature branch
3. Add tests for new functionality
4. Run tests: `bats tests/unit/` and Docker E2E tests
5. Submit a PR

---

## 📜 License

MIT
