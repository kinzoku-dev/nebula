{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; {
  home = {
    user = {
      enable = true;
      name = config.snowfallorg.user.name;
    };
    apps = {
      gui = {
        kitty.enable = true;
        anyrun.enable = true;
      };
      tools = {
        direnv.enable = true;
      };
      cli = {
        # doom-emacs.enable = true;
        lf.enable = true;
        # neomutt.enable = true;
      };
    };
    desktop = {
      mako.enable = true;
      waybar.enable = true;
      colorscheme = "catppuccin-mocha";
      swww.enable = true;
    };
    home-manager.enable = true;
  };
}
