{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.zathura;
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) colors;
in {
  options.apps.zathura = with types; {
    enable = mkBoolOpt false "Enable zathura PDF reader";
  };

  config = mkIf cfg.enable {
    home.programs.zathura = {
      enable = true;
      options = {
        pages-per-row = "1";
        scroll-page-aware = "true";
        scroll-full-overlap = "0.01";
        scroll-step = "100";
        font = "JetbrainsMono Nerd Font 11";

        recolor = "true";

        default-fg = "#${colors.base05}";
        default-bg = "#${colors.base00}";

        completion-bg = "#${colors.base01}";
        completion-fg = "#${colors.base07}";
        completion-highlight-bg = "#${colors.base01}";
        completion-highlight-fg = "#${colors.base07}";
        completion-group-bg = "#${colors.base01}";
        completion-group-fg = "#${colors.base07}";

        statusbar-fg = "#${colors.base07}";
        statusbar-bg = "#${colors.base01}";

        inputbar-fg = "#${colors.base07}";
        inputbar-bg = "#${colors.base01}";
        notification-fg = "#${colors.base07}";
        notification-bg = "#${colors.base01}";
      };
    };
  };
}
