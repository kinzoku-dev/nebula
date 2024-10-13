{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "rofi-run";
  runtimeInputs = with pkgs; [ rofi-wayland ];
  text = ''
    dir="$HOME/.config/rofi/launchers/type-1"
    theme='style-1'

    rofi \
    -show run \
    -theme "''${dir}"/"''${theme}".rasi
  '';
}
