{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.impermanence;
in {
  options.system.impermanence = with types; {
    enable = mkBoolOpt false "Enable impermanence";
    root = {
      directories = mkOpt (listOf string) [] "persist dirs in root";
      files = mkOpt (listOf string) [] "persist files in root";
      cache = mkOpt (listOf string) [] "persist dirs in root (dont snapshot)";
    };
    home = {
      directories = mkOpt (listOf string) [] "persist dirs in home";
      files = mkOpt (listOf string) [] "persist files in home";
    };
    tmpfs = mkBoolOpt false "Enable tmpfs";
    erase = mkBoolOpt config.system.impermanence.tmpfs "Enable rollback to blank for / and /home";
  };

  config = mkIf cfg.enable {
    #TODO: SET UP TMPFS
    services.zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };
    boot = {
      supportedFilesystems = ["zfs"];
      kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
      zfs = {
        devNodes = lib.mkDefault "/dev/disk/by-id";
        enableUnstable = true;
      };
      initrd.postDeviceCommands = lib.mkAfter ''
        ${lib.optionalString (!cfg.tmpfs && cfg.erase) "zfs rollback -r zroot/root@blank"}
      '';
    };
    fileSystems."/persist".neededForBoot = true;
    environment.persistence = {
      "/persist" = {
        hideMounts = true;
        files = ["/etc/machine-id"] ++ cfg.root.files;
        directories =
          [
            "/etc/nixos"
            "/var/log"
            "/var/lib/bluetooth"
            "/var/lib/nixos"
            "/var/lib/systemd/coredump"
            "/etc/NetworkManager/system-connections"
          ]
          ++ cfg.root.directories;
        users.${user} = {
          files = cfg.home.files;
          directories =
            [
              "Downloads"
              "Documents"
              "Audio"
              "Video"
              "Images"
              "Dev"
              "Desktop"
              ".ssh"
              ".gnupg"
              ".nixops"
              ".local/share/keyrings"
              ".local/share/direnv"
              ".local/share/Steam"
            ]
            ++ cfg.home.directories;
        };
      };
      "/persist/cache" = {
        hideMounts = true;
        directories = cfg.root.cache;
      };
    };
  };
}
