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
  persistCfg = config.system.persist;
in {
  options.system.impermanence = with types; {
    enable = mkBoolOpt false "Enable impermanence";
    tmpfs = mkBoolOpt true "Enable tmpfs";
    erase = mkBoolOpt config.system.impermanence.tmpfs "Enable rollback to blank for / and /home";
  };
  options.system.persist = with types; {
    root = {
      dirs = mkOpt (listOf string) [] "persist dirs in root";
      files = mkOpt (listOf string) [] "persist files in root";
      cache = mkOpt (listOf string) [] "persist dirs in root (dont snapshot)";
    };
    home = {
      dirs = mkOpt (listOf string) [] "persist dirs in home";
      files = mkOpt (listOf string) [] "persist files in home";
    };
  };

  config = mkIf cfg.enable {
    #TODO: SET UP TMPFS

    boot = {
      # Clear /tmp on boot
      tmp.cleanOnBoot = true;

      # booting with zfs
      supportedFilesystems = ["zfs"];
      kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
      zfs = {
        devNodes = lib.mkDefault "/dev/disk/by-id";
        enableUnstable = true;
      };

      # root fs is destroyed and rebuilt on every boot
      initrd.postDeviceCommands = lib.mkAfter ''
        ${lib.optionalString (!cfg.tmpfs && cfg.erase) "zfs rollback -r zroot/root@blank"}
      '';
    };

    services.zfs = {
      autoScrub.enable = true;
      trim.enable = true;
    };

    # set persist fs as neededForBoot
    fileSystems = {
      "/" = mkIf (cfg.tmpfs && cfg.erase) (
        lib.mkForce {
          device = "tmpfs";
          fsType = "tmpfs";
          neededForBoot = true;
          options = [
            "defaults"
            "size=1G"
            "mode=755"
          ];
        }
      );
      "/persist".neededForBoot = true;
      "/persist/cache".neededForBoot = true;
    };

    systemd.services.systemd-udev-settle.enable = false;

    # persist config
    environment.persistence = {
      "/persist" = {
        hideMounts = true;
        files = ["/etc/machine-id"] ++ persistCfg.root.files;
        directories =
          [
            "/var/log"
          ]
          ++ persistCfg.root.dirs;
        users.${config.user.name} = {
          files = persistCfg.home.files;
          directories =
            [
              ".cache/dconf"
              ".config/dconf"
            ]
            ++ persistCfg.home.dirs;
        };
      };
      "/persist/cache" = {
        hideMounts = true;
        directories = persistCfg.root.cache;
      };
    };
  };
}
