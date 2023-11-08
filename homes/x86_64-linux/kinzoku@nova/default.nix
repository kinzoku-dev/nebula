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
      };
      tools = {
        direnv.enable = true;
      };
      cli = {
        # doom-emacs.enable = true;
        lf.enable = true;
      };
    };
    home-manager.enable = true;
  };
}
