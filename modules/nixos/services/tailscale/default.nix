{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.tailscale;
in {
  options.tailscale = with types; {
    enable = mkBoolOpt false "Enable tailscale";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.tailscale];

    services.tailscale = {
      enable = true;
    };
  };
}
