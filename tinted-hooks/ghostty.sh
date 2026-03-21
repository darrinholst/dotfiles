#!/usr/bin/env bash

if [[ -z "$BASE16_COLOR_00_HEX" ]]; then
  return
fi

new_conf="palette = 0=#${BASE16_COLOR_00_HEX}
palette = 1=#${BASE16_COLOR_08_HEX}
palette = 2=#${BASE16_COLOR_0B_HEX}
palette = 3=#${BASE16_COLOR_0A_HEX}
palette = 4=#${BASE16_COLOR_0D_HEX}
palette = 5=#${BASE16_COLOR_0E_HEX}
palette = 6=#${BASE16_COLOR_0C_HEX}
palette = 7=#${BASE16_COLOR_05_HEX}
palette = 8=#${BASE16_COLOR_03_HEX}
palette = 9=#${BASE16_COLOR_09_HEX}
palette = 10=#${BASE16_COLOR_01_HEX}
palette = 11=#${BASE16_COLOR_02_HEX}
palette = 12=#${BASE16_COLOR_04_HEX}
palette = 13=#${BASE16_COLOR_06_HEX}
palette = 14=#${BASE16_COLOR_0F_HEX}
palette = 15=#${BASE16_COLOR_07_HEX}
background = #${BASE16_COLOR_00_HEX}
foreground = #${BASE16_COLOR_05_HEX}"

ghostty_conf="$BASE16_CONFIG_PATH/ghostty-theme.conf"
existing_conf="$(cat "$ghostty_conf" 2>/dev/null)"

if [[ "$new_conf" != "$existing_conf" ]]; then
  printf '%s\n' "$new_conf" >| "$ghostty_conf"
fi
