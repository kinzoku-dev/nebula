{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.server.nginx;
in {
  options.server.nginx = with types; {
    enable = mkBoolOpt false "Enable nginx";
    enableAcme = mkBoolOpt false "Enable nginx acme";
    upstreams = mkOpt attrs {} "";
    virtualHosts = mkOpt attrs {} "";
    acmeCloudflareAuthFile = mkOpt (nullOr path) null "";
  };
  config = mkIf cfg.enable {
    services.nginx = {
      enable = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      inherit (cfg) upstreams;
      virtualHosts =
        cfg.virtualHosts
        // {
          "_" = {
            root = "/var/www/placeholder";
          };
        };
    };
    security.acme = mkIf cfg.enableAcme {
      acceptTerms = true;
      defaults = {
        email = "kinzoku@the-nebula.xyz";
        dnsProvider = "cloudflare";
        dnsResolver = "1.1.1.1:53";
        environmentFile = cfg.acmeCloudflareAuthFile;
      };
    };
  };
}
