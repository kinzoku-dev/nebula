{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.sddm;
in {
  options.desktop.sddm = with types; {
    enable = mkBoolOpt false "Enable sddm display manager";
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.sddm.enable = true;
  };
}
