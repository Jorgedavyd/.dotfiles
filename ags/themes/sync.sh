#!/bin/bash

# sync.sh
# Sync ricable things to the current theme

theme=$1

if [ -z $theme ]; then
  echo "Theme is required"
  echo '$ sync.sh <theme>'

  exit 1
fi

case $theme in
    "kanagawa-dragon") GHOSTTY_THEME="Kanagawa Dragon" ; OBSIDIAN_THEME="Kanagawa" ;;
    "kanagawa-wave")   GHOSTTY_THEME="Kanagawa Wave" ; OBSIDIAN_THEME="Kanagawa" ;;
    "oxocarbon")       GHOSTTY_THEME="Oxocarbon" ; OBSIDIAN_THEME="Default" ;;
    "gruvbox")         GHOSTTY_THEME="GruvboxDark" ; OBSIDIAN_THEME="Obsidian gruvbox" ;;
    "nord")            GHOSTTY_THEME="nord" ; OBSIDIAN_THEME="Obsidian Nord" ;;
    "catppuccin-frappe")    GHOSTTY_THEME="catppuccin-frappe" ; OBSIDIAN_THEME="catppuccin" ;;
    "catppuccin-mocha")     GHOSTTY_THEME="catppuccin-mocha" ; OBSIDIAN_THEME="catppuccin" ;;
    "catppuccin-macchiato") GHOSTTY_THEME="catppuccin-macchiato" ; OBSIDIAN_THEME="catppuccin" ;;
    "rose-pine-moon")       GHOSTTY_THEME="rose-pine-moon" ; OBSIDIAN_THEME="Rose Pine" ;;
    *) exit 1 ;;
esac

WALLPAPERS_PATH="$HOME/.config/swww"
AGS_PATH="$HOME/.config/ags"
HYPR_PATH="$HOME/.config/hypr"
GHOSTTY_PATH="$HOME/.config/ghostty"
NVIM_PATH="$HOME/.config/nvim"
LOCAL_STATE="$HOME/.local/state/theme"
VAULT_PATH="/data/OneDrive/Extracurricular/Ilustración/.obsidian"


## setting up wallpapers
current_wall="$LOCAL_STATE/wallpapers"
## resetting the style
rm -rf $current_wall
## symlink of wallpapers
ln -sf "$WALLPAPERS_PATH/$theme" "$LOCAL_STATE/wallpapers"

if [ -f "$WALLPAPERS_PATH/$theme/default.png" ]; then
    ln -sf "$WALLPAPERS_PATH/$theme/default.png" "$LOCAL_STATE/current_wallpaper"
elif [ -f "$WALLPAPERS_PATH/$theme/default.jpg" ]; then
    ln -sf "$WALLPAPERS_PATH/$theme/default.jpg" "$LOCAL_STATE/current_wallpaper"
fi

magick "$LOCAL_STATE/current_wallpaper" \
  -gravity Center \
  -crop 1:1 \
  -resize 500x500 \
  +repage \
  "$LOCAL_STATE/current_wallpaper.crop"

swww img "$LOCAL_STATE/current_wallpaper" \
    --transition-type "wipe" \
    --transition-duration 1

ln -sf "$AGS_PATH/assets/no_music/$theme.png" "$LOCAL_STATE/no_music"

ln -sf "$AGS_PATH/themes/$theme.scss" "$LOCAL_STATE/ags_theme.scss"

ln -sf "$HYPR_PATH/themes/$theme.conf" "$LOCAL_STATE/hypr_theme.conf"
hyprctl reload

## updates the ghostty theme and apply the changes
sed -i "s/^theme = .*/theme = $GHOSTTY_THEME/" "$GHOSTTY_PATH/config"

## updates the neovim theme to the default
sed -i 's/vim\.cmd("colorscheme [^"]*")/vim.cmd("colorscheme '$theme'")/' $NVIM_PATH/lua/jenci/init.lua

for socket in /tmp/nvim-*; do
    nvim --server $socket --remote-send ":colorscheme $theme<CR>"
done

tmpfile=$(mktemp)
jq --arg theme "$OBSIDIAN_THEME" '.cssTheme = $theme' "$VAULT_PATH/appearance.json" > "$tmpfile"

mv "$tmpfile" "$VAULT_PATH/appearance.json"

[ "$(cat "$LOCAL_STATE/theme_changed")" = "0" ] && \
  echo "1" > "$LOCAL_STATE/theme_changed" || \
  echo "0" > "$LOCAL_STATE/theme_changed"
