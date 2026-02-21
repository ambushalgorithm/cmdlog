#!/bin/bash
# cmdlog aliases for bashrc
# Source this file: source /path/to/cmdlog/aliases.sh

# Add cmdlog to PATH if not already there
case ":$PATH:" in *":$HOME/.local/bin/cmdlog:") ;; *) export PATH="$HOME/.local/bin/cmdlog:$PATH" ;; esac

# Aliases
alias cmdlog-recent='cmdlog --recent'
alias cmdlog-today='cmdlog --today'
alias cmdlog-search='cmdlog --search'
alias cmdlog-live='cmdlog --live'
alias cmdlog-raw='cmdlog --raw'
