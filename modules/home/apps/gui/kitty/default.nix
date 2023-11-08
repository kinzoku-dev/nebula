{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.home.apps.gui.kitty;
in {
  options.home.apps.gui.kitty = {
    enable = mkBoolOpt false "enable kitty terminal";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      environment = {};
      font = {
        name = "JetBrains Mono Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        size = 12;
      };
      theme = "Catppuccin-Mocha";
      extraConfig = ''
        disable_ligatures never

        confirm_os_window_close 0

        background #11111b
      '';
      settings = {enable_audio_bell = false;};
    };
  };
}