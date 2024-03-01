{
  config,
  pkgs,
  lib,
  options,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.security.tailscale;
in {
  options.system.security.tailscale = with types; {
    enable = mkBoolOpt false "Enable tailscale";
  };

  config = mkIf cfg.enable {
    services.tailscale.enable = true;
    hardware.networking.fw.trustedIfaces = ["tailscale0"];
  };
}
