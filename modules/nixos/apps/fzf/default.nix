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
  colors = (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}).palette;
in {
  options.apps.fzf = with types; {
    enable = mkBoolOpt false "Enable fzf";
  };

  config = mkIf cfg.enable {
    home.programs.fzf = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      defaultCommand = "fd";
      colors = {
        fg = "#${colors.base05}";
        bg = "#${colors.base00}";
        "bg+" = "#${colors.base02}";
        "fg+" = "#${colors.base0D}";
        border = "#${colors.base07}";
        info = "#${colors.base05}";
        pointer = "#${colors.base08}";
        spinner = "#${colors.base04}";
      };
      defaultOptions = [
        "--height 40%"
        "--border"
        "--bind=ctrl-k:up,ctrl-j:down"
      ];
    };
  };
}
