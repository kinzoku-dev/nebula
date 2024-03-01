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
    nix.allowedUsers = ["@wheel"];
    hardware = {
      networking = {
        nm.enable = true;
        fw = {
          enable = true;
        };
      };
      audio.enable = true;

      bluetoothctl.enable = true;
    };
    system = {
      boot = {
        enable = true;
      };
      ssh = {
        enable = true;
      };

      locale.enable = true;
      security = {
        doas = {
          enable = true;
          replaceSudo = false;
        };
        gnupg.enable = true;
      };
    };
    apps.tools.git.enable = true;

    environment.systemPackages = [pkgs.deploy-rs];
  };
}
