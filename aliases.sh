#!/bin/bash
# cmdlog aliases for bashrc
# Source this file: source ~/Projects/cmdlog/aliases.sh

# Add cmdlog to PATH
case ":$PATH:" in *":$HOME/Projects/cmdlog:") ;; *) export PATH="$HOME/Projects/cmdlog:$PATH" ;; esac

# Aliases
alias cmdlog-recent='cmdlog --recent'
alias cmdlog-today='cmdlog --today'
alias cmdlog-search='cmdlog --search'
alias cmdlog-live='cmdlog --live'
alias cmdlog-raw='cmdlog --raw'
# Legacy alias for backward compatibility
alias cmdlog-grep='cmdlog --search'
