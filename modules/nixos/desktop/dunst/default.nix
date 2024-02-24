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
  cfg = config.desktop.dunst;
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) palette;
in {
  options.desktop.dunst = with types; {
    enable = mkBoolOpt false "Enable dunst";
  };

  config = mkIf cfg.enable {
    home.services.dunst = {
      package = pkgs.dunst;
      enable = true;
      settings = {
        global = {
          markup = "full";
          format = "%s\n%b";
          sort = "no";
          indicate_hidden = "yes";
          alignment = "left";
          show_age_threshold = 60;
          word_wrap = "yes";
          ignore_newline = "no";
          stack_duplicates = "false";
          hide_duplicate_count = "yes";
          corner_radius = 10;
          width = "280";
          height = "50-10";
          offset = "10x30";
          shrink = "no";
          idle_threshold = 120;
          monitor = 0;
          follow = "mouse";
          sticky_history = "yes";
          history_length = 20;
          show_indicators = "no";
          line_height = 4;
          separator_height = 4;
          padding = 20;
          horizontal_padding = 20;
          startup_notification = "true";
          browser = "x-www-browser -new-tab";
          always_run_script = "true";
          title = "Dunst";
          class = "Dunst";
          icon_position = "left";
          min_icon_size = "32";
          max_icon_size = "56";
          frame_width = "3";
        };

        shortcuts = {
          close = "ctrl+shift+space";
          close_all = "ctrl+shift+space";
        };
        urgency-normal = {
          frame_color = "#${palette.base07}";
          foreground = "#${palette.base05}";
          background = "#${palette.base01}99";
        };
        urgency-critical = {
          frame_color = "#${palette.base08}";
          foreground = "#${palette.base08}";
          background = "#${palette.base01}99";
        };
      };
    };
  };
}
