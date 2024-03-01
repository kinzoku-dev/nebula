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
    bootloader = mkOpt (enum ["grub" "systemd-boot"]) "grub" "Bootloader to use";
  };

  config = mkIf cfg.enable {
    boot = {
      loader = {
        systemd-boot.enable = cfg.bootloader == "systemd-boot";
        grub = mkIf (cfg.bootloader == "grub") {
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
  };
}
