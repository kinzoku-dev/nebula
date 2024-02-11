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
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) colors;
  browserCfg = config.apps.browser;
  firefoxEnabled = let
    found = lib.lists.findFirstIndex (x: x == "firefox") null browserCfg.enable;
  in
    if found == "firefox"
    then true
    else false;
in {
  config = {
    # home.programs.firefox =
    #   /*
    #   mkIf firefoxEnabled
    #   */
    #   {
    #     enable = true;
    #     package = pkgs.firefox-devedition;
    #     profiles = {
    #       kinzoku = {
    #         name = "Kinzoku";
    #         settings = {
    #         };
    #         search.default = "DuckDuckGo";
    #         search.engines = {
    #           "SearXNG" = {
    #             urls = [
    #               {
    #                 template = "https://search.the-nebula.xyz/search?q={searchTerms}";
    #               }
    #             ];
    #           };
    #           "DuckDuckGo" = {
    #             urls = [
    #               {
    #                 template = "https://duckduckgo.com/?q={searchTerms}";
    #               }
    #             ];
    #           };
    #         };
    #         bookmarks = [
    #           {
    #             url = "https://github.com";
    #           }
    #           {
    #             url = "https://app.skiff.com/mail/";
    #           }
    #           {
    #             name = "Nix sites";
    #             toolbar = true;
    #             bookmarks = [
    #               {
    #                 name = "homepage";
    #                 url = "https://nixos.org/";
    #               }
    #               {
    #                 name = "wiki";
    #                 url = "https://nixos.wiki/";
    #               }
    #               {
    #                 name = "mynixos";
    #                 url = "https://mynixos.com/";
    #               }
    #               {
    #                 name = "noogle";
    #                 url = "https://noogle.dev/";
    #               }
    #             ];
    #           }
    #           {
    #             name = "Docs";
    #             toolbar = true;
    #             bookmarks = [
    #               {
    #                 name = "Rust";
    #                 url = "https://docs.rust-lang.org/std/index.html";
    #               }
    #               {
    #                 name = "Golang";
    #                 url = "https://pkg.go.dev/std";
    #               }
    #               {
    #                 name = "Crates";
    #                 url = "https://crates.io";
    #               }
    #             ];
    #           }
    #         ];
    #         isDefault = true;
    #         extensions = with config.nur.repos.rycee.firefox-addons; [
    #           darkreader
    #           vimium-c
    #           libredirect
    #           stylus
    #           ublock-origin
    #         ];
    #       };
    #     };
    #   };
    # home.programs.schizofox = {
    #   enable = true;
    #
    #   theme = {
    #     background-darker = "${colors.base01}";
    #     background = "${colors.base00}";
    #     foreground = "${colors.base05}";
    #     font = "JetBrainsMono Nerd Font Mono";
    #     darkreader.enable = true;
    #   };
    #
    #   search = {
    #     defaultSearchEngine = "Searx";
    #     removeEngines = ["Google" "Bing"];
    #     searxUrl = "https://sx.the-nebula.xyz";
    #     searxQuery = "https://sx.the-nebula.xyz/search?q={searchTerms}";
    #   };
    #
    #   misc = {
    #     drmFix = true;
    #     disableWebgl = false;
    #   };
    #
    #   extensions = {
    #     extraExtensions = {
    #       "7esoorv3@alefvanoon.anonaddy.me".install_url = "https://addons.mozilla.org/firefox/downloads/latest/libredirect/latest.xpi";
    #       "vimium-c@gdh1995.cn".install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-c/latest.xpi";
    #       "{446900e4-71c2-419f-a6a7-df9c091e268b}".install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
    #     };
    #   };
    # };
  };
}
