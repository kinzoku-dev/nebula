{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.OxO;
in {
  options.OxO = with types; {
    enable = mkBoolOpt false "Enable 0x0";
  };

  config = mkIf cfg.enable {
    services.uwsgi = {
      enable = true;
      plugins = ["python3"];
    };

    systemd.services = {
      "0x0" = {
        description = "uWSGI instance to serve 0x0";
        after = "network.target";
        serviceConfig = {
          User = "${config.user.name}";
          Group = "www-data";
          WorkingDirectory = "/home/${config.user.name}/0x0";
          ExecStart = "uwsgi --plugin python3 --socket 0.0.0.0:9628 --protocol=http --wsgi-file fhost.py --callable app";
        };
        wantedBy = "multi-user.target";
      };
    };
  };
}
