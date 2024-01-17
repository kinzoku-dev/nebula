{
  config,
  pkgs,
  options,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.spotify-tui;
in {
  options.apps.spotify-tui = with types; {
    enable = mkBoolOpt false "Enable spotify-tui";
  };

  config = mkIf cfg.enable {
    home.configFile."spotifyd/spotifyd.conf".text = ''
      [global]
      username = "312btsqljfuz4lpbqjkv3tjnofk4"
      password = "${lib.removeSuffix "\n" (builtins.readFile config.sops.secrets.spotifyd-password.path)}"
      backend = "pulseaudio"
    '';
    environment.systemPackages = with pkgs; [
      spotify-tui
    ];
    home.configFile."spotify-tui/client.yml".text = ''
      ---
      client_id: c91cae8f6c6b46929046d0cccd84905d
      client_secret: ffaaf43f26e94a3fa693b1d838cd7718
      port: 8888
    '';
  };
}
