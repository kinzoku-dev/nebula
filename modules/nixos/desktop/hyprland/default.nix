{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.desktop.hyprland;
in {
  options.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable hyprland";
    monitors = mkOption {
      type = types.listOf (types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "DP-1";
          };
          width = mkOption {
            type = types.int;
            example = 1920;
          };
          height = mkOption {
            type = types.int;
            example = 1080;
          };
          refreshRate = mkOption {
            type = types.int;
            default = 60;
          };
          x = mkOption {
            type = types.int;
            default = 0;
          };
          y = mkOption {
            type = types.int;
            default = 0;
          };
          enabled = mkOption {
            type = types.bool;
            default = true;
          };
        };
      });
    };
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

    home.configFile = let
      monitorList = lib.concatLines (
        map
        (
          m: let
            resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
            position = "${toString m.x}x${toString m.y}";
          in "monitor=${m.name},${
            if m.enabled
            then "${resolution},${position},1"
            else "disable"
          }"
        )
        cfg.monitors
      );
    in {
      "hypr/hyprland.conf" = {
        text = import ./hyprland.nix {inherit monitorList;};
        onChange = ''
          ${pkgs.hyprland}/bin/hyprctl reload
        '';
      };
    };
  };
}
