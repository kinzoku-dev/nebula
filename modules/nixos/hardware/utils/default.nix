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
  cfg = config.hardware.utils;
in {
  options.hardware.utils = with types; {
    enable = mkBoolOpt false "Enable hardware utils";
  };

  config = mkIf cfg.enable {
    home = {
      programs = {
        btop = {
          enable = true;
          package = pkgs.btop.overrideAttrs {
            desktopItems = [
              (pkgs.makeDesktopItem {
                name = "btop";
                desktopName = "btop++";
                exec = "kitty btop";
                icon = "btop";
                genericName = "System Monitor";
                keywords = [
                  "hardware"
                  "cpu"
                  "gpu"
                  "memory"
                  "disk"
                ];
              })
            ];
          };
          settings = {
            color_theme = "dracula";
            theme_background = false;
            vim_keys = true;
          };
        };
        bottom = {
          enable = true;
        };
      };
    };

    environment.systemPackages = with pkgs; [
      lm_sensors
      nvtop-amd
      pipes
    ];

    services.udisks2.enable = true;
    home.services.udiskie.enable = true;
  };
}
