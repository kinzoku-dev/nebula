{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.boot;
in {
  options.system.boot = with types; {
    enable = mkBoolOpt false "Enable boot stuff";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot.enable = false;
      grub = {
        enable = true;
        theme = pkgs.nebula.catppuccin-grub;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };
}
