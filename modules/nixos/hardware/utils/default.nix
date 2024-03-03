{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.hardware.utils;
in {
  options.hardware.utils = with types; {
    enable = mkBoolOpt false "Enable hardware utils";
  };

  config = mkIf cfg.enable {
    home = {
      programs.btop = {
        enable = true;
        settings = {
          color_theme = "catppuccin_mocha";
          theme_background = false;
          vim_keys = true;
        };
      };
      programs.cava = {
        enable = true;
        settings = {};
      };
    };

    environment.systemPackages = with pkgs; [
      lm_sensors
      nvtop-amd
    ];

    services.udisks2.enable = true;
    home.services.udiskie.enable = true;
  };
}
