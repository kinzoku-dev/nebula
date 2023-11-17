{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.misc;
in {
  options.apps.misc = with types; {
    enable = mkBoolOpt false "Enable or disable misc apps";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      btop
      xclip
      cron
      feh

      nitrogen
      xfce.mousepad
      xfce.thunar
      gimp
      gucharmap
    ];
  };
}
