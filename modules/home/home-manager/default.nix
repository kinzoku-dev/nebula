{
  config,
  options,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.home.home-manager;
in {
  options.home.home-manager = with types; {
    enable = mkBoolOpt true "Enable home-manager.";
  };

  config = mkIf cfg.enable {
    programs.home-manager.enable = true;
  };
}
