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

  config =
    mkIf cfg.enable {
    };
}
