{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.firewall.enable = false;
  services.logind.lidSwitch = "ignore";

  # suites.server.enable = true;
  suites.common.enable = true;
  suites.development.enable = true;
  services.udisks2.enable = true;

  system.stateVersion = "23.11";
}
