{pkgs, ...}:
pkgs.writeShellScriptBin "rofi-calculate" ''
  dir="$HOME/.config/rofi/launchers/calculator"
  theme='style-1'

  rofi \
    -show calc \
    -modi calc \
    -no-show-match \
    -no-sort \
    -theme ''${dir}/''${theme}.rasi \
''
