{
  config,
  options,
  pkgs,
  inputs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.impermanence;
in {
  options.impermanence = with types; {
    enable = mkBoolOpt false "Enable impermanence";
    tmpfs = mkBoolOpt true "Enable tmpfs";
    erase = mkBoolOpt config.impermanence.tmpfs "Enable rollback to blank for / and /home";
  };

  options.environment = with types; {
    # persist = mkOpt (submodule {
    #   options = {
    #     root = mkOpt attrs {} "Files and directories to persist in root";
    #     home = mkOpt attrs {} "Files and directories to persist in home";
    #   };
    # }) {} "Files and directories to persist";
    persist = {
      root = mkOpt attrs {} "Files and directories to persist in root";
      home = mkOpt attrs {} "Files and directories to persist in home";
    };
  };

  # imports = with inputs; [
  #   impermanence.nixosModules.impermanence
  # ];

  config = mkIf cfg.enable {
    boot = {
      # Clear /tmp on boot
      tmp.cleanOnBoot = true;

      # booting with zfs
      supportedFilesystems = ["zfs"];
      kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
      zfs = {
        devNodes = lib.mkDefault "/dev/disk/by-id";
        package = pkgs.zfs_unstable;
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
            "size=5G"
            "mode=755"
          ];
        }
      );
      "/home/${config.user.name}" = mkIf (cfg.tmpfs && cfg.erase) (
        lib.mkForce {
          device = "tmpfs";
          fsType = "tmpfs";
          neededForBoot = true;
          options = [
            "defaults"
            "size=5G"
            "mode=777"
          ];
        }
      );
      "/persist".neededForBoot = true;
      "/persist/cache".neededForBoot = true;
    };

    systemd.services.systemd-udev-settle.enable = false;

    # persist config
    environment.persistence = {
      "/persist" =
        {
          hideMounts = true;
          files = ["/etc/machine-id"];
          directories = [
            "/var/log"
            "/var/lib/nixos"
            "/var/lib/systemd/coredump"
          ];
          users.${config.user.name} =
            {
              files = [];
              directories = [
                ".cache/dconf"
                ".config/dconf"
                ".config/spotify"
              ];
            }
            // (mkAliasDefinitions options.environment.persist.home);
        }
        // (mkAliasDefinitions options.environment.persist.root);
    };
  };
}
