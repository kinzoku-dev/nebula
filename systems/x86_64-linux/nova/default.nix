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
  networking = {
    hostId = "9bf01da4";
    hosts = {
      "::1" = ["localhost" "nova"];
      "127.0.0.1" = ["localhost"];
      "127.0.0.2" = ["nova"];
      "192.168.1.250" = ["nova"];
    };
    interfaces = {
      eno1 = {
        ipv4.addresses = [
          {
            address = "192.168.1.250";
            prefixLength = 24;
          }
        ];
      };
    };
  };

  hardware.graphics = {
    enable = true;
    gpu = "amd";
  };
  suites = {
    common.enable = true;
    development.enable = true;
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
    # apps.spotify-tui.enable = true;
    rofi.enable = true;
    printing.enable = true;
    calcure.enable = true;
    chat.enable = true;
    thunderbird.enable = true;
    vscode.enable = true;
    neofetch.enable = true;
    fzf.enable = true;
    steam.enable = true;
    discord.enable = true;
    mullvad-vpn.enable = true;
    flatpak.enable = true;
    obsidian = {
      enable = true;
    };
    browser.firefox.enable = true;
  };
  desktop = {
    picom.enable = true;
    xmonad.enable = true;
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
          refreshRate = 165;
          x = 0;
          y = 0;
          workspaces = [1 2 3 4 5 6 7 8 9 10];
        }
        {
          name = "DP-2";
          width = 1920;
          height = 1080;
          refreshRate = 165;
          x = 1920;
          y = 0;
          workspaces = [11 12 13 14 15 16 17 18 19 20];
        }
      ];
    };
    waybar.enable = true;
  };

  virtualisation.vm.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
  };

  hardware.openrazer = {
    enable = true;
    users = ["kinzoku"];
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

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget

    webdav.enable = true;
  };
  environment = {
    systemPackages = with pkgs; let
      kinzoku-pkgs = import inputs.nixpkgs-kinzoku {
        system = "x86_64-linux";
        overlays = [];
      };
    in
      [
        inputs.nh.packages.x86_64-linux.default
        vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        wget
        git
        nebula.nix-inspect
        sl
        appimage-run

        pkgs.nebula.discover-overlay
        cinnamon.nemo
        razergenie

        arduino

        gopls
        spotify
        cava

        sops

        nitch

        nebula.kiwi-ssg

        gum

        r2modman

        obs-studio
        xwaylandvideobridge

        libsForQt5.kdenlive

        eww-wayland
        libnotify

        gamemode

        cloudflared

        premid

        gucharmap
        dotnet-sdk

        sl

        prismlauncher

        gpu-screen-recorder-gtk

        mpv

        jre
        minetest

        ngrok

        # kinzoku-pkgs.electron_29-bin

        blender

        udisks

        audacity

        godot_4

        unzip
        zip

        wineWowPackages.waylandFull
        winetricks

        libreoffice

        davinci-resolve

        ungoogled-chromium
        (pkgs.makeDesktopItem {
          name = "satisfactory-mod-manager";
          desktopName = "Satisfactory Mod Manager";
          exec = "${pkgs.appimage-run}/bin/appimage-run /home/kinzoku/.smm/Satisfactory-Mod-Manager.AppImage";
          icon = "/home/kinzoku/.smm/ficsit.png";
          startupWMClass = "satisfactory-mod-manager-gui";
          genericName = "";
          keywords = ["satisfactory" "mod" "manager" "factory"];
        })
      ]
      ++ (
        with inputs.nixpkgs-master.legacyPackages.x86_64-linux; [
          mapscii
        ]
      );

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

  nix.settings.experimental-features = ["nix-command" "flakes"]; # Did you read the comment?
}
