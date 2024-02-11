{pkgs, ...}:
pkgs.writeShellScriptBin "uploader" ''
  dir="$HOME/.config/rofi/launchers/type-1"
  theme='style-1'
  file=$(find $HOME -type f | rofi -dmenu -theme ''${dir}/''${theme}.rasi -p "󰍜")
  url=$(curl -F "file=@$file" https://0x0.the-nebula.xyz)
  wl-copy $url
  notify-send "File has been uploaded to URL $url"
''
