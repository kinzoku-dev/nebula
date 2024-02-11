{pkgs, ...}:
pkgs.writeShellScriptBin "rofi-calc" ''
  dir="$HOME/.config/rofi/launchers/type-1"
  theme='style-1'

  rofi \
    -show drun \
    -theme ''${dir}/''${theme}.rasi
''
