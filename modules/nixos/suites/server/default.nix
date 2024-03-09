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
    system.ssh.port = 42069;
    server = {
      nextcloud.enable = true;
      jellyfin.enable = true;
      prometheus.enable = true;
      postgresql.enable = true;
    };
    services.webdav.enable = true;
    virtualisation.arion.enable = true;
    environment.systemPackages = [pkgs.docker-compose];
  };
}
