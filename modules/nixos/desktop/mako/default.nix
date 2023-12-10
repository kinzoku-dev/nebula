{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.desktop.mako;
in {
  options.desktop.mako = with types; {
    enable = mkBoolOpt false "enable mako notification daemon";
  };

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
    };
  };
}
