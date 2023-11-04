{
  config,
  pkgs,
  options,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.xmonad;
in {
  options.desktop.xmonad = with types; {
    enable = mkBoolOpt false "Enable or disable xmonad";
  };

  config = mkIf cfg.enable {
    home.extraOptions.xsession.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
    };

    services.xserver.windowManager.xmonad.enable = true;

    environment.systemPackages = with pkgs; [
      dmenu
      flameshot

      custom.walslide
    ];
  };
}
