{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.nfs;
in {
  options.system.nfs = with types; {
    enable = mkBoolOpt false "Enable NFS on the current host";
    extraConfig = mkOpt str "" "Extra nfs-utils configuration";
    server = {
      enable = mkBoolOpt false "Whether or not the current host should be an NFS server";
      exports = mkOption {
        type = types.listOf (
          types.submodule {
            options = {
              export = mkOpt str "" "Directory to export";
              clients = mkOption {
                type = types.listOf (
                  types.submodule types.submodule {
                    options = {
                      identifier = mkOpt str "" "Host name/IP address, IP network, or netgroup";
                      opts = mkOpt (listOf str) [] "List of options for the client";
                    };
                  }
                );
                default = [];
                description = "List of clients allowed to mount the share";
              };
            };
          }
        );
        default = [];
        description = "List of file systems to share over NFS";
      };
    };
    internal = {
      exports = mkOption {
        type = types.listOf (
          types.submodule {
            options = {
              export = mkOpt str "" "";
              clients = mkOpt str "" "";
            };
          }
        );
      };
      exportsStrs = mkOpt (listOf str) [] "";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [nfs-utils];

    system.nfs.internal.exports =
      lib.lists.map (
        x: {
          export = "${x.export}";
          clients = lib.lists.map (y: "${y.identifier}(${lib.concatMapStringsSep "," (z: z) y.opts})");
        }
      )
      cfg.server.exports;

    system.nfs.internal.exportsStrs =
      lib.lists.map (
        x: "${x.export} ${x.clients}"
      )
      cfg.internal.exports;

    services.nfs = {
      inherit (cfg) extraConfig;

      server = mkIf cfg.server.enable {
        exports = lib.concatLines cfg.internal.exportsStrs;
      };
    };
  };
}
