{pkgs, ...}: {
  imports = [./hardware-configuration.nix];

  suites.server.enable = true;
  suites.common.enable = true;
  suites.development.enable = true;
  services.udisks2.enable = true;

  system.stateVersion = "23.11";
}
