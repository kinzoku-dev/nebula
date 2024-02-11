{pkgs, ...}:
pkgs.writeShellScriptBin "rofi-wallpaper" ''
  dir="$HOME/.config/rofi/launchers/wallpaper-selector"
  theme='style-1'
  file=$(fd --full-path $HOME -e png -e jpg -e jpeg | rofi -dmenu -theme ''${dir}/''${theme}.rasi -p "󰥶")
  swww img "''${file}" && notify-send "Wallpaper changed"
''
