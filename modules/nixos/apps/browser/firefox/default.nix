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
            search.default = "DuckDuckGo";
            search.engines = {
              "SearXNG" = {
                urls = [
                  {
                    template = "https://search.the-nebula.xyz/?q={searchTerms}";
                  }
                ];
              };
              "DuckDuckGo" = {
                urls = [
                  {
                    template = "https://duckduckgo.com/?q={searchTerms}";
                  }
                ];
              };
            };
            bookmarks = [
              {
                url = "https://github.com";
              }
              {
                url = "https://mail.proton.me";
              }
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
              {
                name = "Docs";
                toolbar = true;
                bookmarks = [
                  {
                    name = "Rust";
                    url = "https://docs.rust-lang.org/std/index.html";
                  }
                  {
                    name = "Golang";
                    url = "https://pkg.go.dev/std";
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
            ];
          };
        };
      };
  };
}
