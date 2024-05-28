{
  device ? throw "Set this to your disk device, e.g. /dev/sda",
  impermanence ? false,
  lib,
  swap ? false,
  ...
}: {
  disko = {
    devices = {
      disk = {
        impermanence = lib.mkIf impermanence {
          inherit device;
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                name = "boot";
                size = "1M";
                type = "EF02";
              };
              esp = {
                name = "ESP";
                size = "500M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
              swap = lib.mkIf swap {
                size = "4G";
                content = {
                  type = "swap";
                  resumeDevice = true;
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "zimpermanence";
                };
              };
            };
          };
        };
        zfs = lib.mkIf (impermanence == false) {
          inherit device;
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              boot = {
                name = "boot";
                size = "1M";
                type = "EF02";
              };
              esp = {
                name = "ESP";
                size = "64M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                };
              };
              swap = lib.mkIf swap {
                size = "4G";
                content = {
                  type = "swap";
                  resumeDevice = true;
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "zfs";
                  pool = "zroot";
                };
              };
            };
          };
        };
      };
      zpool = {
        zroot = lib.mkIf (impermanence == false) {
          type = "zpool";
          rootFsOptions = {
            compression = "zstd";
            "com.sun:auto-snapshot" = "false";
          };
          mountpoint = "/";
          postCreateHook = "zfs list -t snapshot -H -o name | grep -E '^zroot@blank$' || zfs snapshot zroot@blank";

          datasets = {
            nix = {
              type = "zfs_fs";
              mountpoint = "/nix";
              options.mountpoint = "legacy";
            };
            tmp = {
              type = "zfs_fs";
              mountpoint = "/tmp";
              options.mountpoint = "legacy";
            };
          };
        };
        zimpermanence = lib.mkIf impermanence {
          type = "zpool";
          rootFsOptions = {
            canmount = "off";
          };

          datasets = {
            nix = {
              type = "zfs_fs";
              mountpoint = "/nix";
              options.mountpoint = "legacy";
            };
            tmp = {
              type = "zfs_fs";
              mountpoint = "/tmp";
              options.mountpoint = "legacy";
            };
            persist = {
              type = "zfs_fs";
              mountpoint = "/persist";
              options.mountpoint = "legacy";
            };
            persist-cache = {
              type = "zfs_fs";
              mountpoint = "/persist/cache";
              options.mountpoint = "legacy";
            };
          };
        };
      };
    };
  };
}
