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
        "e6478296-6135-47a0-8497-ae9b740bc804" = {
          credentialsFile = "/home/kinzoku/.cloudflared/e6478296-6135-47a0-8497-ae9b740bc804.json";
          default = "http_status:404";
          ingress = {
            "ssh.the-nebula.xyz" = {
              service = "ssh://localhost:22";
            };
          };
        };
      };
    };
    environment.systemPackages = [pkgs.cloudflared];

    virtualisation.arion.enable = true;
    virtualisation.arion.projects.cloudflare.settings = {
      project.name = "cloudflare";
      services.cloudflare.service = {
        image = "cloudflare/cloudflared:latest";
        command = ["tunnel" "--no-autoupdate" "run" "--token" "${secrets.cloudflared-token.path}"];
        volumes = [
          "/home/${config.user.name}:/srv"
        ];
      };
    };

    users.users.${config.user.name}.extraGroups = ["docker"];
  };
}
