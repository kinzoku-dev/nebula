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
      settings = {
        hmac_key = "${builtins.readFile config.sops.secrets.invHmacKey.path}";
      };
    };
  };
}
