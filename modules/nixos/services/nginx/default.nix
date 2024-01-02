{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.nginx;
in {
  options.nginx = with types; {
    enable = mkBoolOpt false "Enable nginx";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      certbot
      python311Packages.certbot
    ];
    services.nginx = {
      enable = true;
      user = "kinzoku";
      group = "www-data";
      virtualHosts = {
        "0x0.the-nebula.xyz" = mkIf config.OxO.enable {
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

                uwsgi_pass unix:/home/kinzoku/0x0/0x0/0x0.sock;
              '';
            };
            "/up" = {
              root = /home/kinzoku/0x0/0x0;
              extraConfig = ''
                internal;
              '';
            };
          };
        };
      };
    };
  };
}
