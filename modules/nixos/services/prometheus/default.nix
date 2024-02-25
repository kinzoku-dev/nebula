{
  config,
  pkgs,
  options,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.server.prometheus;
in {
  options.server.prometheus = with types; {
    enable = mkBoolOpt false "Enable prometheus";
  };

  config = mkIf cfg.enable {
    services.prometheus = {
      enable = true;
      port = 9090;
      listenAddress = "0.0.0.0";
      globalConfig = {
        scrape_interval = "15s";
        evaluation_interval = "15s";
      };
      exporters = {
        node = {
          enable = true;
        };
        nextcloud = {
          enable = true;
          url = "https://cloud.the-nebula.xyz/ocs/v2.php/apps/serverinfo/api/v1/info";
          username = "root";
          passwordFile = "/etc/nextcloud-admin-pass";
        };
      };
      scrapeConfigs = [
        {
          job_name = "prometheus";
          static_configs = [
            {
              targets = ["localhost:9090"];
            }
          ];
        }
        {
          job_name = "node";
          static_configs = [
            {
              targets = ["localhost:9100"];
            }
          ];
        }
      ];
    };
  };
}
