{
  pkgs,
  options,
  lib,
  config,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.server.services.cloudflare;
in {
  options.server.services.cloudflare = with types; {
    enable = mkBoolOpt false "Enable cloudflare";
  };

  config = mkIf cfg.enable {
    users.users.cloudflared = {
      group = "cloudflared";
      isSystemUser = true;
    };
    users.groups.cloudflared = {};

    systemd.services.cloudflared = {
      wantedBy = ["multi-user.target"];
      after = ["network-online.target" "systemd-resolved.service"];
      serviceConfig = {
        ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token=${builtins.readFile config.sops.secrets.cloudflared-token.path}";
        Restart = "always";
        User = "cloudflared";
        Group = "cloudflared";
      };
    };
  };
}
