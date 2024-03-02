{device ? throw "Set this to your disk device, e.g. /dev/sda", ...}: {
  disko.devices = {
    disk.laptop = {
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
          swap = {
            size = "4G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
          root = {
            name = "root";
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
      # lvs = {
      #   root = {
      #     size = "100%FREE";
      #     content = {
      #       type = "zfs";
      #       extraArgs = ["-f"];
      #
      #       subvolumes = {
      #         "/root" = {
      #           mountpoint = "/";
      #         };
      #
      #         "/persist" = {
      #           mountOptions = ["subvol=persist" "noatime"];
      #           mountpoint = "/persist";
      #         };
      #
      #         "/nix" = {
      #           mountOptions = ["subvol=nix" "noatime"];
      #           mountpoint = "/nix";
      #         };
      #       };
      #     };
      #   };
      # };
    };
  };
}
