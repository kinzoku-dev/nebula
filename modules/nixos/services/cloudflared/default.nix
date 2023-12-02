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
        "d4412cc7-5391-42ed-bd4b-0adbefe51061" = {
          credentialsFile = "/home/kinzoku/.cloudflared/d4412cc7-5391-42ed-bd4b-0adbefe51061.json";
          default = "http_status:404";
          ingress = {
            "ssh.the-nebula.xyz" = "ssh://localhost:22";
          };
        };
      };
    };
    environment.systemPackages = [pkgs.cloudflared pkgs.cloudflare-warp];

    users.users.${config.user.name}.extraGroups = ["docker"];
  };
}
