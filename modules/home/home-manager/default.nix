{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.home.home-manager;
in {
  options.home.home-manager = with types; {
    enable = mkBoolOpt true "Enable home-manager.";
  };

  config = mkIf cfg.enable {
    programs.home-manager.enable = true;
  };
}
