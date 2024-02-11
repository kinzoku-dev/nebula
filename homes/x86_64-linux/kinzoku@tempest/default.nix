{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; {
  home = {
    user = {
      enable = true;
      name = config.snowfallorg.user.name;
    };
    apps = {
      gui = {
        kitty.enable = true;
      };
      cli = {
        # doom-emacs.enable = true;
        # lf.enable = true;
        # neomutt.enable = true;
        # neovim.enable = true;
      };
      # spicetify.enable = true;
    };
    desktop = {
      colorscheme = "catppuccin-mocha";
      swww.enable = true;
    };
    home-manager.enable = true;
  };
}
