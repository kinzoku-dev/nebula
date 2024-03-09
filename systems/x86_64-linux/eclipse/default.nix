{pkgs, ...}: {
  imports = [./hardware-configuration.nix];
  suites = {
    server.enable = true;
    common.enable = true;
    development.enable = true;
  };
  networking.interfaces = {
    enp2s0 = {
      ipv4.addresses = [
        {
          address = "192.168.1.251";
          prefixLength = 24;
        }
      ];
    };
  };
  system = {
    impermanence = {
      enable = true;
    };
    shell.shell = "zsh";

    stateVersion = "23.11";
  };

  networking.hostId = "651f0572";
}
