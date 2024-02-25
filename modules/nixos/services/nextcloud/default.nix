{
  pkgs,
  config,
  lib,
  options,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.server.nextcloud;
in {
  options.server.nextcloud = with types; {
    enable = mkBoolOpt false "Enable nextcloud";
  };

  config = mkIf cfg.enable {
    environment.etc."nextcloud-admin-pass".text = "${builtins.readFile config.sops.secrets.nextcloud-admin-pass.path}";
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud28;
      extraApps = {
        inherit (pkgs.nextcloud28Packages.apps) cookbook notes bookmarks maps tasks spreed previewgenerator phonetrack memories calendar contacts forms;
        news = pkgs.fetchNextcloudApp {
          appName = "news";
          sha256 = "sha256-aePXUn57U+1e01dntxFuzWZ8ILzwbnsAOs60Yz/6zUU=";
          url = "https://github.com/nextcloud/news/releases/download/25.0.0-alpha4/news.tar.gz";
          appVersion = "25.0.0-alpha4";
          license = "agpl3Plus";
        };
      };
      # https = true;
      hostName = "cloud.the-nebula.xyz";
      config = {
        adminpassFile = "/etc/nextcloud-admin-pass";
        dbhost = "127.0.0.1";
        dbname = "nextcloud";
        dbport = 5432;
        dbuser = "nextcloud";
      };
      settings = {
        trusted_domains = [
          "localhost"
          "192.168.1.239"
          "cloud.the-nebula.xyz"
        ];
      };
      home = "/storage/nextcloud";
      datadir = "${config.services.nextcloud.home}";
    };
    # services.nginx = {
    #   enable = true;
    #   virtualHosts = {
    #     ${config.services.nextcloud.hostName} = {
    #       forceSSL = true;
    #       enableACME = true;
    #     };
    #   };
    # };
    # security.acme = {
    #   defaults = {
    #     email = "kinzoku@the-nebula.xyz";
    #   };
    #   certs.default = {
    #     email = "kinzoku@the-nebula.xyz";
    #     listenHTTP = ":80";
    #   };
    #   acceptTerms = true;
    # };
  };
}
