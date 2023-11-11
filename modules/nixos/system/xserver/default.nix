{
  config,
  options,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.xserver;
in {
  options.system.xserver = with types; {
    enable = mkBoolOpt false "Enable xserver";
  };

  config = mkIf cfg.enable {
    services.xserver.enable = true;
  };
}
