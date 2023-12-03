{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.invidious;
in {
  options.invidious = with types; {
    enable = mkBoolOpt false "enable invidious instance";
  };

  config = mkIf cfg.enable {
    services.invidious = {
      enable = true;
      port = 3000;
      domain = "invidious.the-nebula.xyz";
      nginx.enable = true;
      settings = {
        hmac_key = "${builtins.readFile config.sops.secrets.invidious-hmac-key.path}";
        db = {
          user = "kemal";
          dbname = "invidious";
          port = 5432;
          host = lib.mkDefault "localhost";
          password = lib.mkDefault "${builtins.readFile config.sops.secrets.invidious-db-password.path}";
        };
      };
    };

    services.nginx.virtualHosts."invidious.the-nebula.xyz" = {
      listen = [
        {
          addr = "127.0.90.3";
          port = 8080;
        }
      ];
      enableACME = false;
      forceSSL = false;
    };
  };
}
