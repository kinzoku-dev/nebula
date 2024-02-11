{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.nginx-proxy-manager;
in {
  options.nginx-proxy-manager = with types; {
    enable = mkBoolOpt false "Enable nginx proxy manager";
  };

  config = mkIf cfg.enable {
    virtualisation.arion.enable = true;
    virtualisation.arion.projects.nginx-proxy-manager.settings = {
      project.name = "nginx-proxy-manager";
      services.nginx-proxy-manager.service = {
        image = "jc21/nginx-proxy-manager:latest";
        ports = [
          "80:80"
          "81:81"
          "443:443"
        ];
        volumes = [
          "/home/${config.user.name}/.local/share/nginx-proxy-manager/data:/data"
          "/home/${config.user.name}/.local/share/nginx-proxy-manager/letsencrypt:/etc/letsencrypt"
        ];
      };
    };
  };
}
