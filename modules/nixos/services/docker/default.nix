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
      persist = {
        root.directories = [
          "/var/lib/docker"
        ];
        home.directories = [
          ".docker"
        ];
      };

      systemPackages = with pkgs; [
        docker
        docker-compose
      ];
    };
    virtualisation.docker = {
      enable = true;
    };
    user.extraGroups = ["docker"];
  };
}
