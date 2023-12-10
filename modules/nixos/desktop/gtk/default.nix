{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.desktop.gtk;
  catppuccin-mocha-gtk = pkgs.catppuccin-gtk.override {
    accents = ["lavender"];
    size = "compact";
    tweaks = ["rimless"];
    variant = "mocha";
  };
in {
  options.desktop.gtk = with types; {
    enable = mkBoolOpt false "Enable gtk for theming";

    cursorTheme = {
      package = mkOpt package pkgs.bibata-cursors "Cursor theme package";
      name = mkOpt str "Bibata-Modern-Ice" "Cursor theme name";
    };

    theme = {
      package = mkOpt package catppuccin-mocha-gtk "Gtk theme package";
      name = mkOpt str "Catppuccin-Mocha-Compact-Lavender-Dark" "Gtk theme name";
    };

    iconTheme = {
      package = mkOpt package pkgs.papirus-icon-theme "Icon theme package";
      name = mkOpt str "Papirus-Dark" "icon theme name";
    };
  };

  config = mkIf cfg.enable {
    home.pointerCursor = {
      name = "Catppuccin-Mocha-Lavender-Cursors";
      package = pkgs.catppuccin-cursors.mochaLavender;
      size = 24;
      gtk.enable = true;
      x11.enable = true;
    };
    home.extraOptions = {
      gtk = {
        enable = true;
        theme = {
          package = cfg.theme.package;
          name = cfg.theme.name;
        };
        iconTheme = {
          package = cfg.iconTheme.package;
          name = cfg.iconTheme.name;
        };
        font = {
          package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
          name = "JetBrainsMono Nerd Font";
        };
      };
    };
  };
}
