{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.yazi;
in {
  options.apps.yazi = with types; {
    enable = mkBoolOpt false "Enable yazi terminal file manager";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      yazi
    ];

    home.configFile."yazi/theme.toml".source = ./mocha.toml;
    home.configFile."yazi/keymap.toml".source = ./keymap.toml;
  };
}
