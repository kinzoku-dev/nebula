{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.neofetch;
in {
  options.apps.neofetch = with types; {
    enable = mkBoolOpt false "Enable neofetch";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.neofetch];

    home.configFile."neofetch/config.conf" = {
      source = ./config.conf;
      recursive = true;
      executable = true;
    };

    home.configFile."neofetch/logo" = {
      source = ./logo;
      recursive = true;
      executable = true;
    };
  };
}
