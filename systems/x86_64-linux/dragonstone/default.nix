{
  config,
  pkgs,
  ...
}: {
  imports = [./hardware-configuration.nix];

  networking = {
    hostId = "9bf01da5";
    nameservers = ["192.168.3.0"];
    interfaces."eth0" = {
      useDHCP = false;
      ipv4.addresses = [
        {
          address = "192.168.3.5";
          prefixLength = 17;
        }
      ];
    };
  };

  suites = {
    common.enable = true;
    development.enable = true;
  };
  system = {
    boot.enable = true;

    fonts = {
      enable = true;
    };
    # system.xremap.enable = true;
    shell.shell = "zsh";

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    stateVersion = "23.05";
  };
  programs = {
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      # Add any missing dynamic libraries for unpackaged programs
      # here, NOT in environment.systemPackages
    ];

    dconf.enable = true;
  };
  apps = {
    security.enable = true;
    tools = {
      network.enable = true;
    };
    misc = {
      enable = true;
    };
    printing.enable = true;
    neofetch.enable = true;
    fzf.enable = true;
    clusterUtils.enable = true;
  };

  virtualisation.kvm.enable = true;

  services = {
    docker.enable = true;
    podman.enable = true;

    webdav.enable = true;
  };

  # Enable Bootloader (EFI or BIOS)
  #system.boot.efi.enable = true;
  #system.boot.bios.enable = true;

  # Better battery life on laptops
  # system.battery.enable = true;

  # suites.desktop.enable = true;
  # suites.development.enable = true;

  # suites.server.enable = true;

  # Nvidia Drivers
  # hardware.nvidia.enable = true;

  # Add packages (custom for ones in these dotfiles)
  # environment.systemPackages = with pkgs; [
  #   custom.package
  # ];
}
