{pkgs, ...}: {
  imports = [./hardware-configuration.nix];
  suites = {
    server.enable = true;
    common.enable = true;
    development.enable = true;
  };

  system.stateVersion = "23.11";
}
