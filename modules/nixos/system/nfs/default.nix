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
              hosts = mkOption {
                type = types.listOf (
                  types.submodule types.submodule {
                    options = {
                      name = mkOpt str "" "Host name";
                    };
                  }
                );
              };
            };
          }
        );
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [nfs-utils];

    services.nfs = {
      inherit (cfg) extraConfig;

      server = mkIf cfg.server.enable {};
    };
  };
}
