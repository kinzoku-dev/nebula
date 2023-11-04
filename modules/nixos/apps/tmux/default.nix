{
  config,
  pkgs,
  lib,
  options,
  ...
}:
with lib;
with lib.custom; let
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

        set -g prefix C-a
        unbind C-b
        bind-key C-a send-prefix
        unbind %
        bind | split-window -h

        unbind '"'
        bind - split-window -v

        unbind r
        bind r source-file ~/.config/tmux/tmux.conf

        bind -r j resize-pane -D 5
        bind -r k resize-pane -U 5
        bind -r l resize-pane -R 5
        bind -r h resize-pane -L 5

        bind -r m resize-pane -Z

        set -g mouse on
      '';
      plugins = with pkgs; [
        tmuxPlugins.vim-tmux-navigator
      ];
    };
  };
}
