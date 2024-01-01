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
      port = 6969;
      database = {
        port = 5432;
      };
      domain = "invidious.the-nebula.xyz";
      settings = {
        db = {
          user = "invidious";
        };
        hmac_key = "${lib.removeSuffix "\n" (builtins.readFile config.sops.secrets.invidious-hmac-key.path)}";
        check_tables = true;
        default_user_preferences.dark_mode = "dark";
        external_port = lib.mkForce 443;
        captions = ["English" "Turkish" "Polish"];
      };
    };
  };
}
