{device ? throw "Set this to your disk device, e.g. /dev/sda", ...}: {
  disko = {
    devices = {
      disk.main = {
        inherit device;
        type = "disk";
        imageSize = "2G";
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
            swap = {
              size = "4G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
      zpool = {
        zroot = {
          type = "zpool";
          rootFsOptions = {
            compression = "zstd";
            "com.sun:auto-snapshot" = "false";
          };
          mountpoint = "/";
          postCreateHook = "zfs snapshot zroot@blank";

          datasets = {
            nix = {
              type = "zfs_fs";
              mountpoint = "/nix";
            };
            tmp = {
              type = "zfs_fs";
              mountpoint = "/tmp";
            };
            persist = {
              type = "zfs_fs";
              mountpoint = "/persist";
            };
            persist-cache = {
              type = "zfs_fs";
              mountpoint = "/persist/cache";
            };
          };
        };
      };
    };
  };
}
