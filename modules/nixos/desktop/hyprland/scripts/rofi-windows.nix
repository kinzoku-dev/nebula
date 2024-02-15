{pkgs, ...}:
pkgs.writeShellApplication {
  name = "rofi-windows";
  runtimeInputs = with pkgs; [rofi-wayland];
  text = ''
    dir="$HOME/.config/rofi/launchers/type-1"
    theme='style-1'

    rofi \
    -show window \
    -theme "''${dir}"/"''${theme}".rasi
  '';
}
