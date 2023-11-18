# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  options,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.networking = {
    enable = true;
    hostname = "nova";
  };
  hardware.audio.enable = true;
  hardware.nvidia.enable = true;
  hardware.bluetoothctl.enable = true;

  system.locale = {
    enable = true;
    timezone = "America/Chicago";
  };

  apps.misc.enable = true;
  apps.tools.git.enable = true;
  apps.tools.nix.enable = true;
  apps.steam.enable = true;
  apps.neovim.enable = true;
  apps.tmux.enable = true;
  apps.brave.enable = true;
  apps.discord.enable = true;
  apps.yazi.enable = true;
  desktop.picom.enable = true;
  desktop.polybar.enable = true;
  apps.foot.enable = true;
  apps.flatpak.enable = true;

  system.sops.enable = true;

  system.xserver.enable = true;
  desktop.xmonad.enable = true;
  desktop.sddm.enable = true;
  desktop.hyprland = {
    enable = true;
    monitors = [
      {
        name = "HDMI-A-1";
        width = 1920;
        height = 1080;
        refreshRate = 75;
        x = 0;
        y = 0;
        enabled = true;
      }
    ];
  };
  system.systemd-timers.enable = true;

  security.gnupg.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

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
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    nebula.nix-inspect
    sl

    gopls
    spotify
    cava

    sops

    element-desktop
    nitch

    nebula.kiwi-ssg

    gum
    obsidian

    r2modman

    nebula.nebulauncher
  ];

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
