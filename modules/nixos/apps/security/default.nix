{
  config,
  pkgs,
  options,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.security;
in {
  options.apps.security = with types; {
    enable = mkBoolOpt false "Enable security apps";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      openssl
      apacheHttpd
    ];
  };
}
