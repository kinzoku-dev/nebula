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
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  options.home.apps.spicetify = with types; {
    enable = mkBoolOpt false "Enable spicetify";
  };

  imports = [inputs.spicetify-nix.homeManagerModule];

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
