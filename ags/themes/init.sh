#!/bin/bash

DEFAULT_THEME="rose-pine-moon"
GHOSTTY_THEME="rose-pine-moon"

WALLPAPERS_PATH="$HOME/.config/swww"
HYPR_THEME="$HOME/.config/hypr"
AGS_PATH="$HOME/.config/ags"
GHOSTTY_PATH="$HOME/.config/ghostty"
NVIM_PATH="$HOME/.config/nvim"
LOCAL_STATE="$HOME/.local/state/theme"

[[ ! -e "$LOCAL_STATE" ]] && mkdir "$LOCAL_STATE"

ln -s "$WALLPAPERS_PATH/$DEFAULT_THEME" "$LOCAL_STATE/wallpapers"

if [ -f "$WALLPAPERS_PATH/$DEFAULT_THEME/default.png" ]; then
    ln -sf "$WALLPAPERS_PATH/$DEFAULT_THEME/default.png" "$LOCAL_STATE/current_wallpaper"
elif [ -f "$WALLPAPERS_PATH/$DEFAULT_THEME/default.jpg" ]; then
    ln -sf "$WALLPAPERS_PATH/$DEFAULT_THEME/default.jpg" "$LOCAL_STATE/current_wallpaper"
fi

magick "$LOCAL_STATE/current_wallpaper" \
  -gravity Center \
  -crop 1:1 \
  -resize 500x500 \
  +repage \
  "$LOCAL_STATE/current_wallpaper.crop"

ln -s "$HYPR_THEME/themes/$DEFAULT_THEME.conf" "$LOCAL_STATE/hypr_theme.conf"
ln -s "$AGS_PATH/themes/$DEFAULT_THEME.scss" "$LOCAL_STATE/ags_theme.scss"
ln -s "$AGS_PATH/assets/no_music/$DEFAULT_THEME.png" "$LOCAL_STATE/no_music"
sed -i "s/^theme = .*/theme = $GHOSTTY_THEME/" "$GHOSTTY_PATH/config"
sed -i 's/vim\.cmd("colorscheme [^"]*")/vim.cmd("colorscheme '$DEFAULT_THEME'")/' $NVIM_PATH/lua/jenci/init.lua
