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

  system.boot.enable = true;

  networking.hosts = {
    "::1" = ["localhost" "nova"];
    "127.0.0.1" = ["localhost"];
    "127.0.0.2" = ["nova"];
    "192.168.1.129" = ["nixos" "eclipse"];
  };

  hardware.graphics = {
    enable = true;
    gpu = "amd";
  };
  hardware.bluetoothctl.enable = true;
  hardware.utils.enable = true;

  suites.common.enable = true;
  suites.development.enable = true;
  system.security.doas.noPassword = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  apps.misc.enable = true;
  apps.zathura.enable = true;
  # apps.spotify-tui.enable = true;
  apps.rofi.enable = true;
  apps.printing.enable = true;
  apps.calcure.enable = true;
  apps.chat.enable = true;
  apps.thunderbird.enable = true;
  apps.vscode.enable = true;
  apps.neofetch.enable = true;
  apps.fzf.enable = true;
  apps.steam.enable = true;
  apps.discord.enable = true;
  apps.mullvad-vpn.enable = true;
  desktop.picom.enable = true;
  apps.flatpak.enable = true;
  apps.obsidian = {
    enable = true;
  };
  apps.browser = {
    enable = [
      "firefox"
      "librewolf"
    ];
    defaultBrowser = "librewolf";
  };

  virtualisation.vm.enable = true;

  system.xserver.enable = true;
  system.fonts = {
    enable = true;
  };

  programs.dconf.enable = true;
  # system.xremap.enable = true;
  system.shell.shell = "fish";
  desktop.xmonad.enable = true;
  desktop.sddm.enable = true;
  desktop.gtk.enable = true;
  desktop.xdg.enable = true;
  desktop.dunst.enable = true;
  desktop.hyprland = {
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
  desktop.waybar.enable = true;
  system.systemd-timers.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.common.default = "*";
  };

  hardware.openrazer = {
    enable = true;
    users = ["kinzoku"];
  };

  services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;
    motherboard = "amd";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  services.gvfs.enable = true;
  services.webdav.enable = true;

  system.security.doas.replaceSudo = lib.mkForce true;

  environment.systemPackages = with pkgs; let
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

      nebula.houston

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
      nmap

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

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
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

  nix.settings.experimental-features = ["nix-command" "flakes"];
  services.udisks2.enable = true;

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
  system.stateVersion = "23.05"; # Did you read the comment?
}
