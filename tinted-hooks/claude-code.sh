#!/usr/bin/env bash

claude_conf="$HOME/.claude.json"

if [[ -z "$BASE16_COLOR_00_HEX" || ! -f "$claude_conf" ]] || ! command -v jq >/dev/null; then
  return
fi

background_luminance=$(( (299 * 16#${BASE16_COLOR_00_HEX:0:2} + 587 * 16#${BASE16_COLOR_00_HEX:2:2} + 114 * 16#${BASE16_COLOR_00_HEX:4:2}) / 1000 ))
theme="dark-ansi"
(( background_luminance > 128 )) && theme="light-ansi"

if [[ "$(jq -r '.theme // empty' "$claude_conf")" != "$theme" ]]; then
  tmp_conf="$(mktemp "$claude_conf.XXXXXX")"
  jq --arg theme "$theme" '.theme = $theme' "$claude_conf" >| "$tmp_conf" && command mv -f "$tmp_conf" "$claude_conf"
fi
