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
  cfg = config.apps.zathura;
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) palette;
  colors = palette;
in {
  options.apps.zathura = with types; {
    enable = mkBoolOpt false "Enable zathura PDF reader";
  };

  config = mkIf cfg.enable {
    home.programs.zathura = {
      enable = true;
      options = {
        pages-per-row = "1";
        scroll-page-aware = "true";
        scroll-full-overlap = "0.01";
        scroll-step = "100";
        font = "JetbrainsMono Nerd Font 11";

        recolor = "true";
      };
    };
  };
}
