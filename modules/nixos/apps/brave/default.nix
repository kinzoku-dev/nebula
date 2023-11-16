{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.brave;
in {
  options.apps.brave = with types; {
    enable = mkBoolOpt false "Enable or disable brave web browser";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.brave];
  };
}
