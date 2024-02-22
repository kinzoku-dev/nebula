{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.ssh;
in {
  options.system.ssh = with types; {
    enable = mkBoolOpt false "Enable ssh";
    port = mkOpt int 22 "SSH port";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [
        cfg.port
      ];
    };
  };
}
