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
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = with inputs; [spicetify-nix.homeManagerModule];
  options.home.apps.gui.spicetify = with types; {
    enable = mkBoolOpt false "enable spicetify";
  };

  config = mkIf cfg.enable {
    programs.spicetify = {
      enable = true;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";

      spotifyPackage = pkgs.spotify;

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
      ];
    };
  };
}
