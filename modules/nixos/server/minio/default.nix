{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.server.minio;
in {
  options.server.minio = with types; {
    enable = mkBoolOpt false "Enable minio";
    package = mkPackageOption pkgs "minio" {};
    dataDir = mkOpt str "/var/lib/minio/data" "";
    rootCredentialsFile = mkOpt (nullOr path) null "";
    enableReverseProxy = mkBoolOpt false "Enable minio reverse proxy";
    minioConsoleURL = mkOpt (nullOr str) null "";
    minioS3URL = mkOpt (nullOr str) null "";
  };

  config = mkIf cfg.enable {
    server.nginx = mkIf cfg.enableReverseProxy {
      enable = true;
      virtualHosts = {
        "${cfg.minioS3URL}" = {
          enableACME = config.server.nginx.enableAcme;
          acmeRoot = null;
          forceSSL = config.server.nginx.enableAcme;
          extraConfig = ''
            client_max_body_size 0;
            proxy_buffering off;
            proxy_request_buffering off;
          '';
          locations."/" = {
            proxyPass = "http://127.0.0.1:9000/";
          };
        };
        "${cfg.minioConsoleURL}" = {
          enableACME = config.server.nginx.enableAcme;
          acmeRoot = null;
          forceSSL = config.server.nginx.enableAcme;
          locations."/" = {
            proxyPass = "http://127.0.0.1:9001/";
            extraConfig = ''
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "upgrade";
            '';
          };
        };
      };
    };

    services.minio = {
      enable = true;
      inherit (cfg) package;
      dataDir = [
        cfg.dataDir
      ];
      inherit (cfg) rootCredentialsFile;
    };
  };
}
