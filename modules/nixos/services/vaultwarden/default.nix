{
  config,
  pkgs,
  lib,
  options,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.server.vaultwarden;
in {
  options.server.vaultwarden = with types; {
    enable = mkBoolOpt false "Enable vaultwarden";
  };

  config = mkIf cfg.enable {
    services.vaultwarden = {
      enable = true;
      backupDir = "/storage/vaultwarden/backup";
      dbBackend = "postgresql";
      config = {
        ROCKET_ADDRESS = "::1";
        ROCKET_PORT = 8222;

        DATABASE_URL = "postgresql://127.0.0.1:5432/vaultwarden";
      };
    };
  };
}
