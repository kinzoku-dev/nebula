{
  config,
  pkgs,
  lib,
  options,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.server.minio;
in {
  options.server.minio = with types; {
    enable = mkBoolOpt false "Whether or not to enable MinIO.";
  };

  config = mkIf cfg.enable {
    services.minio = {
      enable = true;
      dataDir = [
        "/mnt/storage/minio/data"
      ];
      configDir = "/mnt/storage/minio/config";
      consoleAddress = ":9001";
      listenAddress = ":9000";
      region = "us-east-1";
      rootCredentialsFile = "/etc/nixos/minio-root-credentials";
    };

    environment.etc."nixos/minio-root-credentials" = {
      text = ''
        admin:Futter1738*()
      '';
    };
  };
}
