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
    home.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = ["${defaultBrowser}.desktop"];
        "x-scheme-handler/http" = ["${defaultBrowser}.desktop"];
        "x-scheme-handler/https" = ["${defaultBrowser}.desktop"];
        "x-scheme-handler/about" = ["${defaultBrowser}.desktop"];
        "x-scheme-handler/unknown" = ["${defaultBrowser}.desktop"];
        "x-scheme-handler/url" = ["${defaultBrowser}.desktop"];
        "application/xhtml_xml" = ["${defaultBrowser}.desktop"];
        "application/url" = ["${defaultBrowser}.desktop"];
      };
    };
  };
}
