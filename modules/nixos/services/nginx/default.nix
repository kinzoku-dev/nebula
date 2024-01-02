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
      };
    };
  };
}
