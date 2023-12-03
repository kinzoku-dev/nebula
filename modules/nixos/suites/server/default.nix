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
    invidious.enable = true;
    nginx.enable = true;
    users.users.postgres.ignoreShellProgramCheck = true;
  };
}
