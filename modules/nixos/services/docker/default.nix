{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.services.docker;
in {
  options.services.docker = with types; {
    enable = mkBoolOpt false "Enable docker";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        docker
        docker-compose
      ];
    };
    system.persist = {
      root.dirs = [
        "/var/lib/docker"
      ];
      home.dirs = [
        ".docker"
      ];
    };
    virtualisation.docker = {
      enable = true;
    };
    user.extraGroups = ["docker"];
  };
}
