{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.browser;
in {
  options.apps.browser = with types; {
    enable = mkOpt (listOf (enum ["librewolf" "firefox" "brave" "chromium"])) [] "What browsers to enable";
    defaultBrowser = mkOpt (enum ["librewolf" "firefox" "brave" "chromium"]) "firefox" "Which browser should be the default browser";
  };

  config = let
    defaultBrowser = cfg.defaultBrowser;
  in {
    # home.mimeApps = {
    #   enable = true;
    #   associations.added = {
    #     "text/html" = ["librewolf.desktop"];
    #     "x-scheme-handler/http" = ["librewolf.desktop"];
    #     "x-scheme-handler/https" = ["librewolf.desktop"];
    #     "x-scheme-handler/about" = ["librewolf.desktop"];
    #     "x-scheme-handler/unknown" = ["librewolf.desktop"];
    #     "x-scheme-handler/url" = ["librewolf.desktop"];
    #     "application/xhtml_xml" = ["librewolf.desktop"];
    #     "application/url" = ["librewolf.desktop"];
    #   };
    #   defaultApplications = {
    #     "text/html" = ["librewolf.desktop"];
    #     "x-scheme-handler/http" = ["librewolf.desktop"];
    #     "x-scheme-handler/https" = ["librewolf.desktop"];
    #     "x-scheme-handler/about" = ["librewolf.desktop"];
    #     "x-scheme-handler/unknown" = ["librewolf.desktop"];
    #     "x-scheme-handler/url" = ["librewolf.desktop"];
    #     "application/xhtml_xml" = ["librewolf.desktop"];
    #     "application/url" = ["librewolf.desktop"];
    #   };
    # };
    #
    # environment.sessionVariables = {
    #   DEFAULT_BROWSER = "${pkgs.librewolf}/bin/librewolf";
    # };
  };
}
