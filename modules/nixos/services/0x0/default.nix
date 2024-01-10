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
      user = "${config.user.name}";
      instance = {
        type = "emperor";
        vassals = {
          OxO = {
            type = "normal";
            plugins = ["python3"];
            pythonPackages = self:
              with pkgs.python311Packages; [
                flask
                sqlalchemy
                validators
                requests
                python_magic
                flask_sqlalchemy
                flask-sqlalchemy
                flask_migrate
                flask-migrate
              ];
            wsgi-file = "/home/${config.user.name}/0x0/fhost.py";
            callable = "app";
            master = true;
            processes = "5";
            uid = "kinzoku:www-data";
            socket = "127.0.0.1:9627";
            chown-socket = "kinzoku:www-data";
            chmod-socket = "664";
            chdir = "/home/${config.user.name}/0x0";
            vacuum = true;
            die-on-term = true;
          };
        };
      };
    };

    environment.systemPackages = with pkgs;
      [
        (uwsgi.overrideAttrs {
          basePlugins = lib.concatStringsSep "," ["python"];
        })
      ]
      ++ (with pkgs.python311Packages; [
        flask
        sqlalchemy
        validators
        requests
        python_magic
      ]);

    systemd.services = {
      # "0x0" = {
      #   description = "uWSGI instance to serve 0x0";
      #   after = ["network.target"];
      #   serviceConfig = {
      #     User = "${config.user.name}";
      #     Group = "www-data";
      #     WorkingDirectory = "/home/${config.user.name}/0x0";
      #     ExecStart = "${(pkgs.uwsgi.overrideAttrs {
      #       basePlugins = lib.concatStringsSep "," ["python"];
      #     })}/bin/uwsgi --ini 0x0.ini";
      #   };
      #   wantedBy = ["multi-user.target"];
      # };
    };
    services.nginx = {
      enable = true;
      user = "${config.user.name}";
      group = "www-data";
      virtualHosts."0x0" = {
        root = /home/kinzoku/0x0;
        listen = [
          {
            addr = "0.0.0.0";
            port = 9628;
          }
        ];
        locations = {
          "/" = {
            extraConfig = ''
              uwsgi_param QUERY_STRING $query_string;
              uwsgi_param REQUEST_METHOD $request_method;
              uwsgi_param CONTENT_TYPE $content_type;
              uwsgi_param CONTENT_LENGTH $content_length;
              uwsgi_param REQUEST_URI $request_uri;
              uwsgi_param PATH_INFO $document_uri;
              uwsgi_param DOCUMENT_ROOT $document_root;
              uwsgi_param SERVER_PROTOCOL $server_protocol;
              uwsgi_param REMOTE_ADDR $remote_addr;
              uwsgi_param REMOTE_PORT $remote_port;
              uwsgi_param SERVER_ADDR $server_addr;
              uwsgi_param SERVER_PORT $server_port;
              uwsgi_param SERVER_NAME $server_name;
              uwsgi_pass 127.0.0.1:9627;
            '';
          };
          "/up" = {
            extraConfig = ''
              internal;
            '';
          };
        };
      };
    };
  };
}
