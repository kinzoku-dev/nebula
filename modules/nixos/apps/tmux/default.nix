{
  config,
  pkgs,
  lib,
  options,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.tmux;
  theme = inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme};
  colors = theme.palette;
in {
  options.apps.tmux = with types; {
    enable = mkBoolOpt false "Enable or disable tmux the terminal multiplexer";
  };

  config = mkIf cfg.enable {
    home.programs.tmux = {
      enable = true;
      baseIndex = 1;
      keyMode = "vi";
      prefix = "C-a";
      sensibleOnTop = true;
      extraConfig = ''
        set -g escape-time 10

        unbind %
        bind | split-window -h -c "#{pane_current_path}"

        unbind '"'
        bind - split-window -v -c "#{pane_current_path}"

        unbind n
        bind-key n command-prompt -I "rename-window %%"

        unbind N
        bind-key N command-prompt -I "rename-session %%"

        unbind '&'
        bind C-x kill-window

        bind-key x kill-pane

        unbind r
        bind r source-file ~/.config/tmux/tmux.conf

        bind -n M-H previous-window
        bind -n M-L next-window
        bind -n S-Left  previous-window
        bind -n S-Right next-window

        set-window-option -g mode-keys vi

        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

        set -g @dracula-show-powerline true
        set -g @dracula-show-battery false
        set -g @dracula-show-left-sep 
        set -g @dracula-show-right-sep 
        set -g @dracula-fixed-location "Chelsea, AL"
        set -g @dracula-plugins "weather time"
        set -g @dracula-show-flags true
        set -g @dracula-show-left-icon session
        set -g status-position top
      '';
      plugins = with pkgs.tmuxPlugins; [
        vim-tmux-navigator
        dracula
        yank
        tmux-fzf
        # base16-tmux
        # base16-statusline
      ];
    };
  };
}
