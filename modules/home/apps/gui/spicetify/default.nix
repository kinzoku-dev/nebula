{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.home.apps.gui.spicetify;
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];
  options.home.apps.gui.spicetify = with types; {
    enable = mkBoolOpt false "enable spicetify";
  };

  config = mkIf cfg.enable {
    programs.spicetify = {
      enable = true;
      theme = inputs.spicetify-nix.packages.${pkgs.system}.default.themes.catppuccin;
      colorScheme = "mocha";
    };
  };
}
