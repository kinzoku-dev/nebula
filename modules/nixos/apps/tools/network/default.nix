{
  config,
  pkgs,
  options,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.tools.network;
in {
  options.apps.tools.network = with types; {
    enable = mkBoolOpt false "Enable network tools";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      inetutils
      net-snmp
      dig
    ];
  };
}
