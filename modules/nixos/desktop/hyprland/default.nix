{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable hyprland";
  };

  imports = [inputs.hyprland.nixosModules.default];

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
      enableNvidiaPatches = true;
    };

    environment.systemPackages = with pkgs; [
      # wallpaper daemon
      swww

      grim
      slurp
      wl-clipboard

      xwaylandvideobridge
    ];

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    home.configFile = {
      "hypr/hyprland.conf".source = ./hyprland.conf;
    };
  };
}
