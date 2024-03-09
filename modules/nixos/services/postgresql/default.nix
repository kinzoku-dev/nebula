{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.server.postgresql;
  databases = {
    nextcloud = {};
    vaultwarden = {};
    invidious = {};
  };
  dbNames = builtins.attrNames databases;
  # authHba = let
  #   allowedLocalUsers =
  #   ["postgres" "kinzoku"];
  #   allowedHosts = ["eclipse"];
  #   hostAuth = lib.concatMapStringsSep "\n" (host: let
  #     hostCfg =
  #   in )
  # in
in {
  options.server.postgresql = with types; {
    enable = mkBoolOpt false "Enable postgresql";
    hasSSL = mkBoolOpt false "SSL support for postgresql";
    extraSettings = mkOption {
      description = "extra settings to add to postgresql";
      type = options.services.postgresql.settings.type;
      default = {};
    };
    internal = {
      databases = mkOption {
        type = attrsOf (submodule {
          options = {
            extensions = mkOption {
              type = listOf str;
              default = [];
            };
            poolMode = mkOption {
              type = enum [null "session" "transaction"];
              default = null;
            };
            poolSize = mkOption {
              type = nullOr int;
              default = null;
            };
          };
        });
        readOnly = true;
      };
      dbNames = mkOption {
        type = listOf str;
        readOnly = true;
      };
    };
  };

  config = mkIf cfg.enable {
    server.postgresql.internal = {
      inherit databases dbNames;
    };
    users.users.postgres = {
      group = "postgres";

      isSystemUser = true;
    };
    users.groups.postgres = {};

    networking.firewall.allowedTCPPorts = [config.services.postgresql.port];
    services.postgresql = {
      enable = true;
      port = 5432;
      authentication = pkgs.lib.mkOverride 10 ''
        local all all trust
        host all all 127.0.0.1/32 trust
        host all all ::1/128 trust
        host sameuser all 127.0.0.1/32 scram-sha-256
        host sameuser all ::1/128 scram-sha-256
      '';
      enableTCPIP = true;
      checkConfig = false;
      settings = {
        password_encryption = "scram-sha-256";
        log_timezone = config.time.timeZone;
        log_line_prefix = lib.mkForce "{%h} [%p] %q%u@%d ";
        log_connections = true;
        ssl =
          if cfg.hasSSL
          then "on"
          else "off";
      };
      ensureDatabases = dbNames;
      ensureUsers =
        map (db: {
          name = db;
          ensureDBOwnership = true;
        })
        dbNames;
    };
  };
}
