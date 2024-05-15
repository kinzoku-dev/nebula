{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.jovian-nixos.nixosModules.default
  ];

  suites.common.enable = true;
  suites.development.enable = true;

  jovian.steam = {
    enable = true;
    autoStart = true;
  };

  networking = {
    hostId = "b9f01da4";
    hosts = {
      "::1" = [
        "localhost"
        "deck"
      ];
      "127.0.0.1" = ["localhost"];
      "127.0.0.2" = ["deck"];
    };
  };
  environment.systemPackages = with pkgs; [];

  hardware.graphics = {
    enable = true;
    gpu = "integrated";
  };

  system = {
    boot.enable = true;
    security.doas = {
      noPassword = true;
      replaceSudo = lib.mkForce true;
    };

    xserver.enable = true;
    fonts = {
      enable = true;
    };
    # system.xremap.enable = true;
    shell.shell = "zsh";
    systemd-timers.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

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
    misc.enable = true;
    zathura.enable = true;
    rofi.enable = true;
    printing.enable = true;
    calcure.enable = true;
    chat.enable = true;
    thunderbird.enable = true;
    neofetch.enable = true;
    fzf.enable = true;
    discord.enable = true;
    browser.firefox.enable = true;
    clusterUtils.enable = true;
    gaming.enable = true;
  };
  desktop = {
    # picom.enable = true;
    # xmonad.enable = true;
    sddm.enable = true;
    gtk.enable = true;
    xdg.enable = true;
    dunst.enable = true;
    hyprland = {
      enable = true;
      displays = [
        {
          name = "DP-1";
          width = 1920;
          height = 1080;
          refreshRate = 75;
          x = 0;
          y = 0;
          workspaces = [
            1
            2
            3
            4
            5
            6
            7
            8
            9
            10
          ];
        }
      ];
    };
    waybar.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
  };
  services = {
    podman.enable = true;
    docker.enable = true;
    # Configure keymap in X11
    xserver = {
      layout = "us";
      xkbVariant = "";
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget

    webdav.enable = true;
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
