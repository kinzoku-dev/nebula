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
    enable = mkBoolOpt false "Whether or not to enable booting utilities.";
    bootloader = mkOpt (enum ["grub" "systemd-boot"]) "grub" "Bootloader to use.";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      systemd-boot = mkIf (cfg.bootloader == "systemd-boot") {
        enable = true;
        configurationLimit = 5;
        editor = false;
      };
      grub = mkIf (cfg.bootloader == "grub") {
        enable = true;
        theme = pkgs.nebula.catppuccin-grub;
        efiSupport = true;
        device = "nodev";
        useOSProber = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };
}
