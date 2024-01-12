{pkgs, ...}:
pkgs.writeShellScriptBin "rofi-windows" ''
  dir="$HOME/.config/rofi/launchers/type-1"
  theme='style-1'

  rofi \
    -show window \
    -theme ''${dir}/''${theme}.rasi
''
