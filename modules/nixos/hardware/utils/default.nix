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
          settings = {
            color_theme = "dracula";
            theme_background = false;
            vim_keys = true;
          };
        };
        bottom = {
          enable = true;
        };
        cava = {
          enable = true;
          settings = {};
        };
      };
      configFile = {
        "cava/config".text =
          ''
            # custom cava config
          ''
          + builtins.readFile "${inputs.catppuccin-cava}/mocha.cava";
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
