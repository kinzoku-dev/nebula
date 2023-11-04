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
        withOpenASAR = true;
      })
    ];
    home.configFile."discord/settings.json".text = ''
      {
        "SKIP_HOST_UPDATE": true,
        "IS_MAXIMIZED": false,
        "IS_MINIMIZED": false,
        "WINDOW_BOUNDS": {
          "x": 24,
          "y": 24,
          "width": 2271,
          "height": 1256
        },
        "openasar": {
          "setup": true,
          "css": "/* Add your own Custom CSS here.\nHave a theme you want to use? Copy and paste the contents here.\nYou need to restart (click the restart button) after changing. */\n\n@import url(\"https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css\");\n"
        },
        "trayBalloonShown": true
      }
    '';
  };
}
