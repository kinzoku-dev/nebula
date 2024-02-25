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
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) palette;
in {
  options.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable hyprland";
    laptop = mkBoolOpt false "Is this system a laptop?";
    displays = mkOption {
      type = types.listOf (types.submodule {
        options = {
          name = mkOption {
            type = types.str;
            example = "DP-1";
            description = "Name of this display, e.g. HDMI-1";
          };
          width = mkOption {
            type = types.int;
            example = 1920;
            description = "Width of this display";
          };
          height = mkOption {
            type = types.int;
            example = 1080;
            description = "Height of this display";
          };
          refreshRate = mkOption {
            type = types.int;
            default = 60;
            description = "Refresh rate of this display";
          };
          x = mkOption {
            type = types.int;
            default = 0;
            description = "X position of this display";
          };
          y = mkOption {
            type = types.int;
            default = 0;
            description = "Y position of this display";
          };
          workspaces = mkOption {
            type = types.listOf int;
            description = "List of workspaces for this display";
          };
        };
      });
      default = [];
      description = "Config for new displays";
    };
  };

  imports = [
    inputs.hyprland.nixosModules.default
    ./scripts
    ./swaylock.nix
  ];

  config = mkIf cfg.enable {
    home.extraOptions.wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
      systemd = {
        enable = true;
        variables = [
          "DISPLAY"
          "XDG_CURRENT_DESKTOP"
        ];
      };
      plugins = with inputs; [
        split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
      ];
      extraConfig = let
        displayList = lib.concatLines (
          map
          (
            m: let
              resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
              position = "${toString m.x}x${toString m.y}";
            in "monitor=${m.name},${"${resolution},${position},1"}"
          )
          cfg.displays
        );
        workspaceMonitors = lib.concatLines (
          lib.lists.concatMap
          (
            m: map (w: "${toString w},monitor:${m.name}") (m.workspaces)
          )
          (cfg.displays)
        );
      in ''
        ${import ./hyprland.nix {
          inherit displayList workspaceMonitors pkgs;
          colors = palette;
        }}
      '';
    };

    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs;
      [
        # wallpaper daemon
        swww

        grim
        slurp

        wl-clipboard
        cliphist

        xwaylandvideobridge

        wlr-randr

        hyprpicker

        (pkgs.flameshot.overrideAttrs {
          src = pkgs.fetchFromGitHub {
            owner = "flameshot-org";
            repo = "flameshot";
            rev = "fa29bcb4279b374ea7753fc4a514fd705499f7e7";
            sha256 = "sha256-XIquratzK4qW0Q1ZYI5X6HIrnx1kTTFxeYeR7hjrpjQ=";
          };
          cmakeFlags = [
            "-DUSE_WAYLAND_GRIM=True"
            "-DUSE_WAYLAND_CLIPBOARD=1"
          ];
          buildInputs = with pkgs; [libsForQt5.kguiaddons];
        })
      ]
      ++ (with inputs.hyprland-contrib.packages.${pkgs.system}; [
        hyprprop
        grimblast
        scratchpad
      ]);

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
  };
}
