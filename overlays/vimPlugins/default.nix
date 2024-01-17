{
  plugin-move,
  plugin-neocord,
  ...
}: (final: prev: {
  vimPlugins =
    prev.vimPlugins
    // {
      move-nvim = prev.vimUtils.buildVimPlugin {
        name = "move";
        src = plugin-move;
      };
      neocord = prev.vimUtils.buildVimPlugin {
        name = "neocord";
        src = plugin-neocord;
      };
    };
})
