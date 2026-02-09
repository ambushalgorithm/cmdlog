#!/bin/bash
# openclaw-cmdlog aliases for bashrc
# Source this file: source /path/to/openclaw-cmdlog/aliases.sh

# Add openclaw-cmdlog to PATH if not already there
case ":$PATH:" in *":$HOME/.local/bin/openclaw-cmdlog:") ;; *) export PATH="$HOME/.local/bin/openclaw-cmdlog:$PATH" ;; esac

# Aliases
alias openclaw-cmdlog-recent='openclaw-cmdlog --recent'
alias openclaw-cmdlog-today='openclaw-cmdlog --today'
alias openclaw-cmdlog-search='openclaw-cmdlog --search'
alias openclaw-cmdlog-live='openclaw-cmdlog --live'
alias openclaw-cmdlog-raw='openclaw-cmdlog --raw'
