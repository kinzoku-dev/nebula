{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.suites.graphical;
in {
  options.suites.graphical = with types; {
    enable = mkBoolOpt false "Enable graphical suite";
  };

  config = mkIf cfg.enable {
    desktop = {
      hyprland.enable = true;
      waybar.enable = true;
      dunst.enable = true;
      gtk.enable = true;
      sddm.enable = true;
    };
    apps = {
      browser.firefox.enable = true;
      discord.enable = true;
      zathura.enable = true;
    };
    suites.common.enable = true;
  };
}
