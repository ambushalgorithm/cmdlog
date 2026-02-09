#!/bin/bash
#
# cmdlog aliases for bashrc
# Source this file or copy the aliases to your .bashrc
#

# Add cmdlog to PATH if not already there
case ":$PATH:" in
  *":$HOME/Projects/cmdlog:") ;;
  *) export PATH="$HOME/Projects/cmdlog:$PATH" ;;
esac

# Quick aliases that delegate to main cmdlog script
alias cmdlog-recent='cmdlog --recent 200'
alias cmdlog-today='cmdlog --today'
alias cmdlog-grep='cmdlog --grep'
alias cmdlog-live='cmdlog --live'

# Optional: keep old commands that point to new ones
alias cmdlog-raw='cmdlog --raw'
