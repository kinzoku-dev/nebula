{
  config,
  pkgs,
  options,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.server.invidious;
in {
  options.server.invidious = with types; {
    enable = mkBoolOpt false "Enable invidious";
  };

  config = mkIf cfg.enable {
    services.invidious = {
      enable = true;
      port = 6942;
      hmacKeyFile = config.sops.secrets.invidious-hmac-key.path;
      database = {
        host = "127.0.0.1";
        port = 5432;
        createLocally = false;
      };
      settings = {
        db.user = "invidious";
        check_tables = true;
        admins = ["kinzoku"];
        https_only = mkForce true;
        statistics_enabled = true;
        default_user_preferences.dark_mode = "dark";
        enable_user_notifications = true;
      };
    };
  };
}
