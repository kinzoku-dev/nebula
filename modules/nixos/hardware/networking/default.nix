{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.hardware.networking;
  fwCfg = config.hardware.networking.fw;
in {
  options.hardware.networking = with types; {
    nm.enable = mkBoolOpt false "Enable networkmanager";
    fw = {
      enable = mkBoolOpt true "Enable firewall";
      trustedIfaces = mkOpt (listOf string) [] "Trusted interfaces list";
      tcp = {
        allowedPorts = mkOpt (listOf port) [] "Allowed TCP ports";
        allowedPortRanges = mkOpt (listOf (attrsOf port)) [] "Allowed TCP port ranges";
      };
      udp = {
        allowedPorts = mkOpt (listOf port) [] "Allowed UDP ports";
        allowedPortRanges = mkOpt (listOf (attrsOf port)) [] "Allowed UDP port ranges";
      };
    };
  };

  config = {
    system.persist.root.dirs = [
      (lib.optionalString cfg.nm.enable "/etc/NetworkManager")
    ];
    environment = {
      systemPackages = with pkgs; [
        nmap
      ];
    };
    networking = {
      networkmanager.enable = cfg.nm.enable;
      firewall = mkIf fwCfg.enable {
        enable = true;
        trustedInterfaces = fwCfg.trustedIfaces;
        allowedTCPPorts = fwCfg.tcp.allowedPorts;
        allowedTCPPortRanges = fwCfg.tcp.allowedPortRanges;
        allowedUDPPorts = fwCfg.udp.allowedPorts;
        allowedUDPPortRanges = fwCfg.udp.allowedPortRanges;
      };
    };
  };
}
