{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.searx;
in {
  options.searx = with types; {
    enable = mkBoolOpt false "Enable searx instance";
  };

  config = mkIf cfg.enable {
    services.searx = {
      enable = true;
      runInUwsgi = true;
      uwsgiConfig = {
        http-socket = ":8080";
      };
      settings = {
        general.instance_name = "SearXNG | the-nebula.xyz";
        search = {
          autocomplete = "duckduckgo";
        };
        server = {
          port = 8080;
          secret_key = "${lib.removeSuffix "\n" (builtins.readFile config.sops.secrets.searx-secret-key.path)}";
          bind_address = "71.150.126.171";
          base_url = "https://sx.the-nebula.xyz";
        };
        redis.url = "redis://127.0.90.4:6379/0";
        ui.theme_args.simple_style = "dark";
        engines = [
          {
            name = "invidious";
            base_url = "https://iv.the-nebula.xyz";
          }
        ];
      };
    };
    services.redis.servers.searx = {
      enable = true;
      bind = "127.0.90.4";
      port = 6379;
    };
  };
}
