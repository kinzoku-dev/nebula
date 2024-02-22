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
    environment.systemPackages = [pkgs.docker-compose];
  };
}
