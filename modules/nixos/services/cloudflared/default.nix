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
  };
}
