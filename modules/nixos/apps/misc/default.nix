{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.misc;
in {
  options.apps.misc = with types; {
    enable = mkBoolOpt false "Enable or disable misc apps";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fzf
      fd
      ripgrep
      vim
      git
      eza
      wget
      btop
      xclip
      bat
      cron
      feh

      nitrogen
      xfce.mousepad
      xfce.thunar
      gimp
      spicetify-cli
      gucharmap

      neofetch
      pfetch
    ];
  };
}
