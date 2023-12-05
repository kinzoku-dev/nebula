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
      address = "127.0.90.3";
      settings = {
        external_port = lib.mkForce 443;
        default_user_preferences.dark_mode = "dark";
        force_resolve = "ipv6";
        check_tables = lib.mkForce false;
        hmac_key = "${builtins.readFile config.sops.secrets.invidious-hmac-key.path}";
        db = {
          user = "invidious";
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
        {
          addr = "127.0.90.3";
          port = 443;
        }
      ];
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
      };
      enableACME = false;
      forceSSL = false;
    };
    users.users.invidious = {
      group = "invidious";
      isSystemUser = true;
      password = "${lib.removeSuffix "\n" (builtins.readFile config.sops.secrets.invidious-user-password.path)}";
    };
    users.groups.invidious = {};
  };
}
