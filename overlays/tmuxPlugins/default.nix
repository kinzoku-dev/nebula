{
  plugin-tmux-base16-statusline,
  plugin-tmux-base16-tmux,
  ...
}: (final: prev: {
  tmuxPlugins =
    prev.tmuxPlugins
    // {
      # base16-statusline = prev.tmuxPlugins.mkTmuxPlugin {
      #   pluginName = "tmux-base16-statusline";
      #   src = plugin-tmux-base16-statusline;
      # };
      base16-tmux = prev.tmuxPlugins.mkTmuxPlugin {
        pluginName = "base16-tmux";
        src = plugin-tmux-base16-tmux;
      };
    };
})
