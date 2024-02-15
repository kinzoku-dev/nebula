{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  uploader = import ./rofi-uploader.nix {inherit pkgs;};
  rofi-drun = import ./rofi-drun.nix {inherit pkgs;};
  rofi-run = import ./rofi-run.nix {inherit pkgs;};
  rofi-windows = import ./rofi-windows.nix {inherit pkgs;};
  rofi-wallpaper = import ./rofi-wallpaper.nix {inherit pkgs;};
  rofi-wifimenu = import ./rofi-wifimenu.nix {inherit pkgs;};
  rofi-pdf = import ./rofi-pdf.nix {inherit pkgs;};
  rofi-calculate = import ./rofi-calculate.nix {inherit pkgs;};
in {
  environment.systemPackages = with pkgs; [
    uploader
    rofi-drun
    rofi-run
    rofi-windows
    rofi-wallpaper
    rofi-wifimenu
    rofi-pdf
    rofi-calculate
  ];
}
