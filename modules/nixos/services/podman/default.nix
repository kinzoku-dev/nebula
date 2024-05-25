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
    system.persist.root.dirs = [
      "/run/user/1000/podman"
    ];
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
