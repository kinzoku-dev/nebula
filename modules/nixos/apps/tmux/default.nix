{
  config,
  pkgs,
  lib,
  options,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.tmux;
in {
  options.apps.tmux = with types; {
    enable = mkBoolOpt false "Enable or disable tmux the terminal multiplexer";
  };

  config = mkIf cfg.enable {
    home.programs.tmux = {
      enable = true;
      baseIndex = 1;
      extraConfig = ''
        set -g default-terminal "screen-256color"
        set -g allow-passthrough on
        set -ga update-environment TERM
        set -ga update-environment TERM_PROGRAM
        set -g escape-time 10

        set -g prefix C-a
        unbind C-b
        bind-key C-a send-prefix
        unbind %
        bind | split-window -h

        unbind '"'
        bind - split-window -v

        unbind r
        bind r source-file ~/.config/tmux/tmux.conf

        unbind n
        bind-key n command-prompt -I "rename-window %%"

        unbind '&'
        bind-key q kill-window

        bind-key x kill-pane

        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

        bind -r j resize-pane -D 5
        bind -r k resize-pane -U 5
        bind -r l resize-pane -R 5
        bind -r h resize-pane -L 5

        bind -r m resize-pane -Z

        set -g mouse on
        set -g renumber-windows on

        set -g status-position top

        set -g @catppuccin_flavour 'mocha'
        set -g @catppuccin_window_left_separator " █"
        set -g @catppuccin_window_right_separator "█"
        set -g @catppuccin_window_middle_separator " | "
        set -g @catppuccin_window_number_position "right"

        set -g @catppuccin_window_default_fill "all"

        set -g @catppuccin_window_current_fill "all"

        set -g @catppuccin_status_modules_right "application session"
        set -g @catppuccin_status_left_separator  ""
        set -g @catppuccin_status_right_separator " "
        set -g @catppuccin_status_fill "all"
        set -g @catppuccin_status_connect_separator "no"
      '';
      plugins = with pkgs; [
        tmuxPlugins.vim-tmux-navigator
        (tmuxPlugins.catppuccin.overrideAttrs (oldAttrs: {
          src = oldAttrs.src.override {
            owner = "kinzoku-dev";
            repo = "catppuccin-tmux";
            rev = "337d605a38fcefda48cef7dc61ddaa5b4f69687c";
            hash = "sha256-gsOazBH5wQcwSoe/+f6t4HU4boypLVr0ySNAk4Tmvo8=";
          };
        }))
      ];
    };
  };
}
