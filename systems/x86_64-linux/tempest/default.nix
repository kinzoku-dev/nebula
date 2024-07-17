# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  options,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking.hostId = "c106acaf";

  hardware.gpu = {
    enable = true;
    gpu = "nvidia";
    nvidiaOffload = {
      enable = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:01:0:0";
    };
  };
  suites = {
    common.enable = true;
    development.enable = true;
  };
  apps = {
    misc.enable = true;
    zathura.enable = true;
    # apps.spotify-tui.enable = true;
    rofi.enable = true;
    calcure.enable = true;
    chat.enable = true;
    neofetch.enable = true;
    fzf.enable = true;
    gaming.enable = true;
    discord.enable = true;
    mullvad-vpn.enable = true;
    obsidian = {
      enable = true;
    };
    browser.firefox.enable = true;
  };
  system = {
    boot.enable = true;
    security.doas = {
      noPassword = true;
      replaceSudo = lib.mkForce true;
    };

    xserver.enable = true;
    impermanence = {
      enable = true;
    };
    fonts = {
      enable = true;
    };
    # system.xremap.enable = true;
    shell.shell = "fish";
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
  desktop = {
    sddm.enable = true;
    gtk.enable = true;
    dunst.enable = true;
    hyprland = {
      enable = true;
      displays = [
        {
          name = "eDP-1";
          width = 1920;
          height = 1080;
          refreshRate = 144;
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

    xdg.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
  };
  services = {
    hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "amd";
    };

    # Configure keymap in X11
    xserver = {
      layout = "us";
      xkbVariant = "";
    };
  };
  environment = {
    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    systemPackages = with pkgs;
      [
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        wget
        git
        nebula.nix-inspect
        sl
        appimage-run
        uutils-coreutils

        gopls
        spotify
        cava

        sops

        nebula.premid-appimage

        nitch

        nebula.kiwi-ssg

        gum

        r2modman

        obs-studio

        libsForQt5.kdenlive

        eww-wayland
        libnotify

        cloudflared

        premid

        gucharmap
        dotnet-sdk

        sl

        prismlauncher

        gpu-screen-recorder-gtk
        libva
        libglvnd
        mesa
        ffmpeg

        mpv

        jre
        minetest
        nmap

        ngrok

        blender

        udisks

        audacity

        godot_4

        unzip
        zip

        libreoffice

        ungoogled-chromium
        (pkgs.makeDesktopItem {
          name = "satisfactory-mod-manager";
          desktopName = "Satisfactory Mod Manager";
          exec = "${pkgs.appimage-run}/bin/appimage-run /home/kinzoku/.smm/Satisfactory-Mod-Manager.AppImage";
          icon = "/home/kinzoku/.smm/ficsit.png";
          startupWMClass = "satisfactory-mod-manager-gui";
          genericName = "";
          keywords = [
            "satisfactory"
            "mod"
            "manager"
            "factory"
          ];
        })
      ]
      ++ (with inputs.nixpkgs-master.legacyPackages.x86_64-linux; [mapscii]);

    sessionVariables = {
      DOTNET_ROOT = "${pkgs.dotnet-sdk}";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ]; # Did you read the comment?
}
