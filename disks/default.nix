{device ? throw "Set this to your disk device, e.g. /dev/sda", ...}: {
  disko = {
    devices = {
      disk = {
      main = {
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
              size = "100%";
              content = {
                type = "zfs";
                pool = "zroot";
              };
            };
          };
        };
      };
      deck = {
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
		pool = "zroot2";
	      };
	    };
	  };
	};
      };
      };
      zpool = {
      	zroot2 = {
	  type = "zpool";
	  mode = "mirror";
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
	  };
	};
        zroot = {
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
