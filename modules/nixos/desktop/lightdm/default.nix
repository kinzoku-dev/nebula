{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.desktop.lightdm;
in {
  options.desktop.lightdm = with types; {
    enable = mkBoolOpt false "Enable lightdm display manager";
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.lightdm.enable = true;
  };
}
