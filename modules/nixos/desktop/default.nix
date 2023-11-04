{
  config,
  options,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop;
in {
  options.desktop = with types; {
    colorscheme = mkOpt str "catppuccin-mocha" "Theme to use for desktop";
  };

  config = {
    prism = {
      enable = true;
      wallpapers = ./wallpapers;
      colorscheme = inputs.nix-colors.colorschemes.${cfg.colorscheme};
    };
  };
}
