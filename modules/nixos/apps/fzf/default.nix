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
  cfg = config.apps.fzf;
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) palette;
in {
  options.apps.fzf = with types; {
    enable = mkBoolOpt false "Enable fzf";
  };

  config = mkIf cfg.enable {
    home.programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd";
      colors = {
        fg = "#${palette.base05}";
        bg = "#${palette.base01}";
      };
      defaultOptions = [
        "--height 40%"
        "--border"
      ];
    };
  };
}
