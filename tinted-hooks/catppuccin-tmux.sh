#!/usr/bin/env bash

# Sync catppuccin tmux flavor when tinted-shell theme changes
read current_theme_name < "$BASE16_SHELL_THEME_NAME_PATH"
flavor="mocha"
case "$current_theme_name" in
  catppuccin-*) flavor="${current_theme_name#catppuccin-}" ;;
esac

printf 'set -g @catppuccin_flavor "%s"\n' "$flavor" >| "$BASE16_CONFIG_PATH/catppuccin-tmux.conf"

if [ -n "$TMUX" ]; then
  # Unset all catppuccin options so -o flags don't keep stale values
  tmux show -g | awk '/^@thm_|^@catppuccin_|^@_ctp_/ {print $1}' | while read -r key; do
    tmux set -gu "$key"
  done
  tmux source-file ~/.tmux.conf
fi
