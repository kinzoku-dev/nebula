{pkgs, ...}:
pkgs.writeShellScriptBin "rofi-run" ''
  dir="$HOME/.config/rofi/launchers/type-1"
  theme='style-1'

  rofi \
    -show run \
    -theme ''${dir}/''${theme}.rasi
''
