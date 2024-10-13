{
  inputs,
  userinfo,
  hostname,
  isServer,
  lib,
  ...
}:
{
  imports = [
    inputs.impermanence.nixosModule
  ];
  boot.tmp.cleanOnBoot = true;
  environment.persistence = {
    "/persist" = {
      files = [ "/etc/machine-id" ];
      directories =
        if isServer then
          [
            "/var/log"
            "/var/lib/systemd/coredump"
            "/etc/NetworkManager"
            "/etc/mullvad-vpn"
            "/mnt/backups"
            "/mnt/storage"
            "/var/lib/nixos-containers"
            "/etc/nixos-containers"
            "/var/lib/nextcloud"
            "/var/lib/jellyfin"
          ]
        else
          [
            "/var/log"
            "/var/lib/bluetooth"
            "/var/lib/systemd/coredump"
            "/etc/NetworkManager"
            "/var/lib/flatpak"
            "/etc/mullvad-vpn"
          ]
          ++ (lib.lists.optionals (hostname == "SATELLITE") [
            "/var/lib/decky-loader"
          ]);
      users.${userinfo.name} = {
        directories =
          if isServer then
            [
              ".config/Mullvad VPN"
              ".config/sops"
              ".local/state/syncthing"
              ".local/share/Steam"
              "Backups"
              ".ssh"
              "NixOS"
            ]
          else
            [
              ".config/Ryujinx"
              ".config/dolphin-emu"
              ".config/melonDS"
              ".config/PCSX2"
              ".config/Cemu"
              ".config/spotify"
              ".config/ags"
              ".config/rpcs3"
              ".config/r2modman"
              ".config/r2modmanPlus-local"
              ".config/sops"
              ".config/vesktop"
              ".config/Vencord"
              ".config/StardewValley"
              ".config/Signal Beta"
              ".config/noisetorch"
              ".config/Mullvad VPN"
              ".config/obs-studio"
              ".config/steam-rom-manager"
              ".config/obsidian"
              ".local/share/bottles"
              ".local/state/syncthing"
              ".local/state/wireplumber"
              ".local/share/lutris"
              ".local/share/StardewValley"
              ".local/share/Steam"
              ".local/share/vinegar"
              ".local/share/citra-emu"
              ".local/share/Cemu"
              ".local/share/flatpak"
              ".local/share/PrismLauncher"
              ".local/share/PollyMC"
              ".local/share/Celeste"
              ".local/share/gvfs-metadata"
              ".local/share/Terraria"
              ".local/share/nemo"
              ".ssh"
              ".klei"
              ".thunderbird"
              ".wine"
              ".var"
              ".steam"
              ".ftba"
              ".minecraft"
              ".mozilla"
              ".mullvad"
              "Backups"
              "Downloads"
              "Desktop"
              "Documents"
              "Games"
              "Programs"
              "Projects"
              "Testing"
              "Audio"
              "Video"
              "Notes"
              "Personal"
              "Images"
              "homebrew"
            ];
      };
    };
  };

  fileSystems = {
    "/" = lib.mkForce {
      device = "tmpfs";
      fsType = "tmpfs";
      neededForBoot = true;
      options = [
        "defaults"
        "size=5G"
        "mode=755"
      ];
    };
    "/home/${userinfo.name}" = lib.mkForce {
      device = "tmpfs";
      fsType = "tmpfs";
      neededForBoot = true;
      options = [
        "defaults"
        "size=5G"
        "mode=755"
      ];
    };
    "/persist".neededForBoot = true;
    "/persist/cache".neededForBoot = true;
  };
  users.users = {
    ${userinfo.name} = {
      hashedPasswordFile = "/persist/passwords/user";
      initialPassword = "nutsitch";
    };
    root = {
      hashedPasswordFile = "/persist/password/root";
    };
    # echo "abcdef" | mkpasswd -s
  };
}
