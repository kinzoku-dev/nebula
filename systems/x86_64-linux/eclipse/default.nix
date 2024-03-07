{pkgs, ...}: {
  imports = [./hardware-configuration.nix];
  suites = {
    server.enable = true;
    common.enable = true;
    development.enable = true;
  };

  networking.hostId = "651f0572";

  system.stateVersion = "23.11";
}
