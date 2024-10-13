{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "rofi-calculate";
  runtimeInputs = with pkgs; [
    rofi-calc
    libqalculate
  ];
  text = ''
    dir="$HOME/.config/rofi/launchers/calculator"
    theme='style-1'

    rofi \
    -modi calc \
    -show calc \
    -theme "''${dir}"/"''${theme}".rasi
  '';
}
