{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.home.desktop.stylix;
in {
  options.home.desktop.stylix = with types; {
    enable = mkBoolOpt false "Enable stylix";
  };
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  config = mkIf cfg.enable {
    stylix = {
      image = /home/${config.home.user.name}/.config/wallpapers/spaceman.png;
      autoEnable = false;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      polarity = "dark";
      cursor = {
        name = "Catppuccin-Mocha-Lavender-Cursors";
        package = pkgs.catppuccin-cursors.mochaLavender;
        size = 32;
      };
      fonts = {
        monospace = {
          package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
          name = "JetBrainsMono Nerd Font";
        };
        serif = config.stylix.fonts.monospace;
        sansSerif = config.stylix.fonts.monospace;
        emoji = {
          package = pkgs.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
      opacity = {
        applications = 0.7;
        popups = 0.7;
        terminal = 0.7;
      };
      targets = {
        fzf.enable = true;
        gtk.enable = true;
        hyprland.enable = true;
        swaylock.enable = true;
        bat.enable = true;
        dunst.enable = true;
        feh.enable = true;
        kitty.enable = true;
        firefox.enable = true;
        nixvim = {
          enable = true;
          transparent_bg = {
            main = true;
            sign_column = true;
          };
        };
        nushell.enable = true;
        rofi.enable = true;
        tmux.enable = true;
        zathura.enable = true;
        waybar.enable = lib.mkForce false;
      };
    };
  };
}
