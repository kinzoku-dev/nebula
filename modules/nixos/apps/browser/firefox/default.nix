{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  browserCfg = config.apps.browser;
  firefoxEnabled = let
    found = lib.lists.findFirstIndex (x: x == "firefox") null browserCfg.enable;
  in
    if found == "firefox"
    then true
    else false;
in {
  config = {
    home.programs.firefox =
      /*
      mkIf firefoxEnabled
      */
      {
        enable = true;
        profiles = {
          kinzoku = {
            name = "Kinzoku";
            settings = {
            };
            userChrome = ''
              ${builtins.readFile ./userChrome}
            '';
            bookmarks = [
              {
                name = "Nix sites";
                toolbar = true;
                bookmarks = [
                  {
                    name = "homepage";
                    url = "https://nixos.org/";
                  }
                  {
                    name = "wiki";
                    url = "https://nixos.wiki/";
                  }
                  {
                    name = "mynixos";
                    url = "https://mynixos.com/";
                  }
                  {
                    name = "noogle";
                    url = "https://noogle.dev/";
                  }
                ];
              }
            ];
            isDefault = true;
            extensions = with config.nur.repos.rycee.firefox-addons; [
              darkreader
              vimium-c
              libredirect
              stylus
              ublock-origin
              enhancer-for-youtube
              firefox-color
            ];
          };
        };
      };
  };
}
