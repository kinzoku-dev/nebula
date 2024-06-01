{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.services.podman;
in {
  options.services.podman = with types; {
    enable = mkBoolOpt false "Enable podman";
  };

  config = mkIf cfg.enable {
    virtualisation.podman = {
      enable = true;
    };
    user.extraGroups = ["podman"];

    environment.systemPackages = with pkgs; [
      podman
      podman-compose
    ];
  };
}
