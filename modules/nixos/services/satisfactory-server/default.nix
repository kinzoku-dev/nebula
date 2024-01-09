{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.satisfactory-server;
in {
  options.satisfactory-server = with types; {
    enable = mkBoolOpt false "Enable satisfactory server";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [steamPackages.steamcmd];
  };
}
