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
    };
    environment.systemPackages = [pkgs.cloudflared pkgs.cloudflare-warp];

    virtualisation.arion.enable = true;

    users.users.${config.user.name}.extraGroups = ["docker"];
  };
}
