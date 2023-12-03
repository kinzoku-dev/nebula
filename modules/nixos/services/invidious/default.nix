{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.invidious;
in {
  options.invidious = with types; {
    enable = mkBoolOpt false "enable invidious instance";
  };

  config = mkIf cfg.enable {
    users.users.postgres.group = "postgres";
    users.groups.postgres = {};
    users.users.postgres.isNormalUser = true;
    virtualisation.arion.enable = true;
    virtualisation.arion.projects.invidious.settings = {
      project.name = "invidious";
      services.invidious.service = {
        image = "quay.io/invidious/invidious:latest";
        ports = [
          "3005:3005"
        ];
        environment = {
          INVIDIOUS_CONFIG = ''
            db:
                dbname: invidious
                user: kinzoku
                password: kinzoku
                host: invidious-db
                port: 5432
            check_tables = true

            hmac_key: "${builtins.readFile config.sops.secrets.invHmacKey.path}"
          '';
        };
      };
      services.invidious-db.service = {
        image = "docker.io/library/postgres:14";
        volumes = [
          "postgresdata:/var/lib/postgresql/data"
          "./config/sql:/home/${config.user.name}/.local/share/invidious-db/config/sql"
          "./docker/init-invidious-db.sh:/home/${config.user.name}/.local/share/invidious-db/docker-entrypoint-initdb.d/init-invidious-db.sh"
        ];
        environment = {
          POSTGRES_DB = "invidious";
          POSTGRES_USER = "kinzoku";
          POSTGRES_PASSWORD = "kinzoku";
        };
      };
      docker-compose.volumes = {
        postgresdata = null;
      };
    };
  };
}
