{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.networking;
in {
  options.hardware.networking = with types; {
    enable = mkBoolOpt false "Enable networkmanager";
    hostname = mkOpt str "nixos" "Networking hostname";
  };

  config = mkIf cfg.enable {
    networking.hostName = cfg.hostname;

    networking.networkmanager.enable = true;
  };
}
