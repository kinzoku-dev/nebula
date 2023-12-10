{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.postgresql;

  databases = [
    "invidious"
    "nextcloud"
  ];
in {
  options.postgresql = with types; {
    enable = mkBoolOpt false "Enable postgresql";
  };

  config = mkIf cfg.enable {
    services.postgresql = {
      enable = true;
      port = 5432;
      settings = {
      };
    };
  };
}
