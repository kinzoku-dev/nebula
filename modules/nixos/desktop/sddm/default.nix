{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.desktop.sddm;
in {
  options.desktop.sddm = with types; {
    enable = mkBoolOpt false "Enable sddm display manager";
  };

  config = mkIf cfg.enable {
    services.xserver.displayManager.sddm = {
      enable = true;
      theme = "${pkgs.nebula.sddm-catppuccin-mocha}";
    };
  };
}
