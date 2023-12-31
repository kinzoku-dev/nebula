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
    home.programs.btop = {
      enable = true;
      settings = {
        theme_background = false;
        vim_keys = true;
        color_theme = "catppuccin_mocha";
      };
    };

    home.configFile."btop/themes/catppuccin_mocha.theme" = {
      source = ./catppuccin_mocha.theme;
      recursive = true;
    };

    environment.systemPackages = with pkgs; [
      lm_sensors
    ];
  };
}
