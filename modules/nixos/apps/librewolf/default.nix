{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.librewolf;
in {
  options.apps.librewolf = with types; {
    enable = mkBoolOpt false "Enable or disable brave web browser";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.librewolf];
  };
}
