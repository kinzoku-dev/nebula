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
      xclip
      cron
      feh

      nitrogen
      xfce.mousepad
      gnome.nautilus
      gimp
      gucharmap

      unzip
      zip
      udisks

      p7zip

      filezilla
    ];
  };
}
