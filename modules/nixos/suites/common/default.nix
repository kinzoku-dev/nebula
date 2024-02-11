{
  pkgs,
  lib,
  options,
  config,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.suites.common;
in {
  options.suites.common = with types; {
    enable = mkBoolOpt false "Enable common suite";
  };

  config = mkIf cfg.enable {
    hardware.networking = {
      enable = true;
    };
    hardware.audio.enable = true;

    hardware.bluetoothctl.enable = true;

    apps.tools.git.enable = true;
    services.ssh.enable = true;

    environment.systemPackages = [pkgs.deploy-rs];

    system = {
      locale.enable = true;
      security = {
        doas.enable = true;
        gnupg.enable = true;
      };
    };
  };
}
