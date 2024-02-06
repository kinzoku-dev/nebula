{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.home.apps.cli.neovim;
in {
  options.home.apps.cli.neovim = with types; {
    enable = mkBoolOpt false "Enable or disable neovim";
  };

  imports = [
    # inputs.nebuvim.homeManagerModules.nebuvim
  ];

  config = mkIf cfg.enable {
    # programs.nebuvim = {
    #   enable = true;
    # };
  };
}
