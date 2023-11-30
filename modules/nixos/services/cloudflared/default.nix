{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.cloudflared;
  secrets = config.sops.secrets;
in {
  options.cloudflared = with types; {
    enable = mkBoolOpt false "Enable cloudflared";
  };

  config = mkIf cfg.enable {
    services.cloudflared = {
      enable = true;
      user = "kinzoku";
      tunnels = {
        "9a844696-e035-42d5-9ffb-27344db7d3b2" = {
          credentialsFile = "/home/kinzoku/.cloudflared/9a844696-e035-42d5-9ffb-27344db7d3b2.json";
          default = "http_status:404";
          ingress = {
            "ssh.the-nebula.xyz" = "ssh://localhost:22";
          };
        };
      };
    };
    environment.systemPackages = [pkgs.cloudflared pkgs.cloudflare-warp];

    # virtualisation.arion.enable = true;
    # virtualisation.arion.projects.cloudflare.settings = {
    #   project.name = "cloudflare";
    #   services.cloudflare.service = {
    #     image = "cloudflare/cloudflared:latest";
    #     command = ["tunnel" "--no-autoupdate" "run" "--token" "${secrets.cloudflared-token.path}"];
    #     volumes = [
    #       "/home/${config.user.name}:/srv"
    #     ];
    #   };
    # };

    users.users.${config.user.name}.extraGroups = ["docker"];
  };
}
