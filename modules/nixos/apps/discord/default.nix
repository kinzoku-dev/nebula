{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.discord;
in {
  options.apps.discord = with types; {
    enable = mkBoolOpt false "Enable or disable discord";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      (pkgs.discord.override {
        withOpenASAR = false;
        withVencord = true;
      })
    ];
    home.file.".config/Vencord/themes/catppuccin.theme.css".source = ./catppuccin.theme.css;
    home.configFile."discord/settings.json".text = ''
      {
        "IS_MAXIMIZED": false,
        "IS_MINIMIZED": false,
        "OPEN_ON_STARTUP": false,
        "MINIMIZE_TO_TRAY": false,
        "SKIP_HOST_UPDATE": true
      }
    '';
  };
}
