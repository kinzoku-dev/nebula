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
      sensibleOnTop = true;
      keyMode = "vi";
      prefix = "C-a";
      extraConfig = ''
        set -g escape-time 10

        unbind %
        bind | split-window -h

        unbind '"'
        bind - split-window -v

        unbind n
        bind-key n command-prompt -I "rename-window %%"

        unbind '&'
        bind C-x kill-window

        bind-key x kill-pane

        unbind r
        bind r source-file ~/.config/tmux/tmux.conf
      '';
      plugins = with pkgs; [
        tmuxPlugins.vim-tmux-navigator
      ];
    };
  };
}
