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
  cfg = config.home.apps.gui.ags;
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.home.desktop.colorscheme}) colors;
in {
  options.home.apps.gui.ags = with types; {
    enable = mkBoolOpt false "enable ags";
  };

  imports = [
    inputs.ags.homeManagerModules.default
  ];

  config = mkIf cfg.enable {
    programs.ags = {
      enable = true;
      extraPackages = [pkgs.libsoup_3];
    };

    xdg.configFile."ags/" = {
      source = ./src;
      recursive = true;
    };

    xdg.configFile."ags/style.css" = {
      text = import ./css/style.nix {inherit colors;};
    };
  };
}
