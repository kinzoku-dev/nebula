{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.vaultwarden;
in {
  options.vaultwarden = with types; {
    enable = mkBoolOpt false "enable vaultwarden";
  };

  config = mkIf cfg.enable {
    services.vaultwarden = {
      enable = true;
      config = {
        ROCKET_ADDRESS = "::";
        ROCKET_PORT = 8812;
      };
    };
  };
}
