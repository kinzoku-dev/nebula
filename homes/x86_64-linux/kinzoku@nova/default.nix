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
        spicetify.enable = true;
      };
      tools = {
        direnv.enable = true;
      };
    };
    home-manager.enable = true;
  };
}
