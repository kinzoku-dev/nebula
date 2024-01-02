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
      virtualHosts = {
        "0x0.the-nebula.xyz" = mkIf config.OxO.enable {
          locations = {
            "/" = {
              extraConfig = ''
                include uwsgi_params;
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
