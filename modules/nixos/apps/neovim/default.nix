{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.neovim;
in {
  options.apps.neovim = with types; {
    enable = mkBoolOpt false "Enable or disable neovim";
  };

  config = mkIf cfg.enable {
    environment.variables = {
      EDITOR = "nvim";
    };

    environment.systemPackages = [
      pkgs.neovim

      pkgs.lazygit
      pkgs.stylua
      pkgs.lua-language-server
      pkgs.ripgrep
    ];
  };
}
