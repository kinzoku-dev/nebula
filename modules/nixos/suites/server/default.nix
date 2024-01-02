{
  pkgs,
  lib,
  options,
  config,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.suites.server;
in {
  options.suites.server = with types; {
    enable = mkBoolOpt false "Enable server suite";
  };

  config = mkIf cfg.enable {
    suites.common.enable = true;
    suites.development.enable = true;
    security.sops.enable = true;
    environment.systemPackages = [pkgs.docker-compose];
    invidious.enable = true;
    vaultwarden.enable = true;
    searx.enable = true;
    nginx-proxy-manager.enable = true;
    rimgo.enable = true;
    uwsgi.enable = true;
    nginx.enable = true;
    OxO.enable = true;
    users = {
      users = {
        postgres = {
          isSystemUser = true;
          group = "postgres";
          ignoreShellProgramCheck = true;
        };
        invidious = {
          group = "invidious";
          isSystemUser = true;
        };
      };
      groups = {
        invidious = {};
        postgres = {};
      };
    };
  };
}
