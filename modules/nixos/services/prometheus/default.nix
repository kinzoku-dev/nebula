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
      ];
    };
  };
}
