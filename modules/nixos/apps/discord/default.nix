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
    home.configFile."discord/settings.json".source = ./settings.json;
  };
}
