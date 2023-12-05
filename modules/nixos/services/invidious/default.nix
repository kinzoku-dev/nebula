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
    enable = mkBoolOpt false "Enable invidious instance";
  };

  config = mkIf cfg.enable {
    services.invidious = {
      enable = true;
      port = 3005;
      database = {
          port = 5432;
      };
      settings = {
          hmac_key = "${lib.removeSuffix "\n" (builtins.readFile config.sops.secrets.invidious-hmac-key.path)}";
          default_user_preferences.dark_mode = "dark";
          external_port = lib.mkForce 3005;
      };
    };
  };
}
