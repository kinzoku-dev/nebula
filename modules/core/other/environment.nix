{ config, ... }:
{
  environment = {
    etc = {
      # universal git config
      "gitconfig".text = config.hm.xdg.configFile."git/config".text;
    };

    sessionVariables = {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      GTK_THEME = "catppuccin-frappe-sky-compact+normal";
      MOZ_ENABLE_WAYLAND = "1";
      RUST_BACKTRACE = "1";
      QT_QPA_PLATFORMTHEME = "qt5ct";
    };
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      NIXPKGS_ALLOW_UFNREE = "1";
      # STARSHIP_CONFIG = "${config.hm.xdg.configHome}/starship.toml";
    };
  };
}
