{
  config,
  pkgs,
  options,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.home.apps.spicetify;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  options.home.apps.spicetify = with types; {
    enable = mkBoolOpt false "Enable spicetify";
  };

  imports = [inputs.spicetify-nix.homeManagerModules.default];

  config = mkIf cfg.enable {
    programs.spicetify = {
      enable = true;
      spotifyPackage = pkgs.spotify;
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "mocha";

      enabledExtensions = with spicePkgs.extensions; [
        fullAppDisplay
        shuffle
        hidePodcasts
        playlistIcons
        loopyLoop
        adblock
      ];
    };
  };
}
