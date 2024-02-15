{pkgs, ...}:
pkgs.writeShellApplication {
  name = "rofi-calculate";
  runtimeInputs = with pkgs; [rofi-wayland rofi-calc libqalculate];
  text = ''
    dir="$HOME/.config/rofi/launchers/calculator"
    theme='style-1'

    rofi \
      -show calc \
      -modi calc \
      -no-show-match \
      -no-sort \
      -theme "''${dir}"/"''${theme}".rasi \
  '';
}
