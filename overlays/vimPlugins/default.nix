{
  plugin-move,
  plugin-neocord,
  plugin-aerial,
  plugin-silicon,
  plugin-nvim-ansible,
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
      aerial-nvim = prev.vimUtils.buildVimPlugin {
        name = "aerial";
        src = plugin-aerial;
      };
      nvim-silicon = prev.vimUtils.buildVimPlugin {
        name = "silicon";
        src = plugin-silicon;
      };
      nvim-ansible = prev.vimUtils.buildVimPlugin {
        name = "ansible";
        src = plugin-nvim-ansible;
      };
    };
})
