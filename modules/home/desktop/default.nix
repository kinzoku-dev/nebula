{
  config,
  options,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.home.desktop;
in {
  options.home.desktop = with types; {
    colorscheme = mkOpt str "catppuccin-mocha" "Theme to use for desktop";
  };

  config = {};
}
