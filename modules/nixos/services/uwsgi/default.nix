{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.uwsgi;
in {
  options.uwsgi = with types; {
    enable = mkBoolOpt false "Enable uwsgi";
  };

  config = mkIf cfg.enable {
    services.uwsgi = {
      enable = true;
      plugins = ["python3"];
    };
    environment.systemPackages = with pkgs; [
      uwsgi
    ];
    systemd.services = {
      "0x0" = mkIf config.OxO.enable {
        enable = true;
        description = "uWSGI instance to serve 0x0";
        after = ["network.target"];
        serviceConfig = {
          User = "kinzoku";
          Group = "www-data";
          WorkingDirectory = "/home/kinzoku/0x0/0x0";
          ExecStart = "${pkgs.uwsgi}/bin/uwsgi --ini 0x0.ini";
        };
        wantedBy = [
          "multi-user.target"
        ];
      };
    };
  };
}
