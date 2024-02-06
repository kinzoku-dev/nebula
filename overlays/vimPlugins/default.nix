{
  plugin-move,
  plugin-neocord,
  plugin-aerial,
  ...
}: (_final: prev: {
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
      aerial-nvim = prev.vimUtils.buildVimPlugin {
        name = "aerial";
        src = plugin-aerial;
      };
    };
})
