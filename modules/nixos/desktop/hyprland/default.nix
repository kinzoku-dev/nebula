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
  colors = palette;
in {
  options.desktop.hyprland = with types; {
    enable = mkBoolOpt false "Enable hyprland";
    laptop = mkBoolOpt false "Is this system a laptop?";
    displays = mkOption {
      type = types.listOf (
        types.submodule {
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
        }
      );
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
      xwayland.enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      systemd = {
        enable = true;
        variables = [
          "DISPLAY"
          "XDG_CURRENT_DESKTOP"
        ];
      };
      plugins = with inputs; [
        # split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
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
          lib.lists.concatMap (m: map (w: "workspace=${toString w},monitor:${m.name}") (m.workspaces)) (
            cfg.displays
          )
        );
      in ''
        ${import ./hyprland.nix {
          inherit
            displayList
            workspaceMonitors
            pkgs
            config
            ;
          colors = palette;
        }}
      '';
    };
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    };

    # home.extraOptions.wayland.windowManager.hyprland = {
    #   enable = true;
    #   settings = {
    #     "$mainMod" = "SUPER";
    #     decoration = {
    #       rounding = 10;
    #       shadow_range = 4;
    #       shadow_render_power = 3;
    #       "col.shadow" = "rgba(1a1a1aee)";
    #       blur = {
    #         size = 3;
    #         passes = 3;
    #         new_optimizations = true;
    #         xray = false;
    #       };
    #     };
    #     layerrule = [
    #       "blur,rofi"
    #       "blur,notifications"
    #     ];
    #     env = [
    #       "WLR_NO_HARDWARE_CURSORS,1"
    #       "GTK_THEME,Catppuccin-Mocha-Compact-Lavender-Dark"
    #       "WLR_DRM_NO_ATOMIC,1"
    #     ];
    #     general = {
    #       border_size = 3;
    #       layout = "dwindle";
    #       gaps_in = 5;
    #       gaps_out = 10;
    #       "col.active_border" = "rgb(${colors.base07})";
    #       "col.inactive_border" = "rgb(${colors.base02})";
    #     };
    #     input = {
    #       kb_options = "caps:escape,grp:win_space_toggle";
    #       kb_layout = "us,us,us";
    #       kb_variant = ",intl,colemak_dh";
    #       accel_profile = "flat";
    #       sensitivity = 0.6;
    #     };
    #     dwindle = {
    #       preserve_split = "yes";
    #     };
    #     bind = [
    #       "$mainMod SHIFT, Return, exec, kitty"
    #       "$mainMod SHIFT, C, killactive"
    #       "$mainMod, P, exec, rofi-drun"
    #       "$mainMod SHIFT, P, exec, powermenu"
    #       "$mainMod, D, exec, rofi-run"
    #       "$mainMod, W, exec, rofi-windows"
    #       "$mainMod, Z, exec, rofi-pdf"
    #       "$mainMod SHIFT, W, exec, rofi-wallpaper"
    #       "$mainMod, N, exec, wifi-menu"
    #       "$mainmod, U, exec, uploader"
    #       "$mainMod, M, exec, rofi-calculate"
    #       "$mainMod, E, exec, emoji"
    #       "$mainMod, B, exec, rofi-clipboard"
    #       "$mainMod SHIFT, S, exec, grimblast --freeze copy area"
    #       "$mainMod, V, togglefloating"
    #       "$mainMod, C, exec, hyprpicker | wl-copy"
    #       "$mainMod, T, togglegroup"
    #       ",XF86AudioRaiseVolume, exec, volume --up"
    #       ",XF86AudioLowerVolume, exec, volume --down"
    #       ",XF86AudioMute, exec, volume --toggle"
    #       "$mainMod, h, movefocus, l"
    #       "$mainMod, l, movefocus, r"
    #       "$mainMod, k, movefocus, u"
    #       "$mainMod, j, movefocus, d"
    #       "$mainMod SHIFT, h, movewindoworgroup, l"
    #       "$mainMod SHIFT, l, movewindoworgroup, r"
    #       "$mainMod SHIFT, k, movewindoworgroup, u"
    #       "$mainMod SHIFT, j, movewindoworgroup, d"
    #       "ALT SHIFT, J, changegroupactive, b"
    #       "ALT SHIFT, K, changegroupactive, f"
    #       "ALT SHIFT, H, movegroupwindow, b"
    #       "ALT SHIFT, L, movegroupwindow, f"
    #     ];
    #   };
    # };

    environment.systemPackages = with pkgs;
      [
        # wallpaper daemon
        swww

        grim
        slurp

        wl-clipboard
        cliphist
        inputs.hyprsome.packages."${pkgs.system}".default

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
