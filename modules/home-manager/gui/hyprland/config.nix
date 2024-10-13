{
  pkgs,
  inputs,
  lib,
  hostname,
  userinfo,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    systemd = {
      enable = true;
      variables = [
        "DISPLAY"
        "XDG_CURRENT_DESKTOP"
      ];
    };
    xwayland.enable = true;
    plugins =
      [
      ];
    settings = {
      "$mainMod" = "SUPER";
      "general:layout" = "dwindle";
      monitor =
        if (hostname == "NOVA") then
          [
            "DP-1,1920x1080@165,0x0,1"
            "DP-2,1920x1080@165,1920x0,1"
          ]
        else
          [ ];
      exec-once =
        [
          "mullvad-gui"
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "hyprctl setcursor macOS 24"
          "discover-overlay"
          "flameshot"
          "sleep 0.5 && waybar"
          "obs --startreplaybuffer"
          "${pkgs.wlsunset}/bin/wlsunset"
          "${pkgs.swaynotificationcenter}/bin/swaync"
          "${pkgs.swayidle}/bin/swayidle -C ~/.config/swayidle/config"
          "${pkgs.swayosd}/bin/swayosd-server"
          "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1"
          "${pkgs.hypridle}/bin/hypridle"
          "${pkgs.wl-clipboard}/bin/wl-copy --type image --watch ${pkgs.cliphist}/bin/cliphist store"
          "${pkgs.wl-clipboard}/bin/wl-copy --type text --watch ${pkgs.cliphist}/bin/cliphist store"
          "${pkgs.arrpc}/bin/arrpc"
          "${pkgs.premid}/bin/premid --in-process-gpu"
        ]
        ++ (lib.lists.optionals (hostname == "NOVA") [
          "${pkgs.swaybg}/bin/swaybg --o DP-1 -i ${../../../../assets/wallpapers/dmc5-vergil-slash.jpg}"
          "${pkgs.swaybg}/bin/swaybg --o DP-2 -i ${../../../../assets/wallpapers/dmc5-brothers.jpg}"
          "${pkgs.noisetorch}/bin/noisetorch -i alsa_input.usb-IK_Multimedia_iRig_Mic_HD_2_N_A-00.mono-fallback"
        ]);
      workspace =
        if (hostname == "NOVA") then
          [
            "1,monitor:DP-1"
            "2,monitor:DP-1"
            "3,monitor:DP-1"
            "4,monitor:DP-1"
            "5,monitor:DP-1"
            "6,monitor:DP-1"
            "7,monitor:DP-1"
            "8,monitor:DP-1"
            "9,monitor:DP-1"
            "10,monitor:DP-1"
            "11,monitor:DP-2"
            "12,monitor:DP-2"
            "13,monitor:DP-2"
            "14,monitor:DP-2"
            "15,monitor:DP-2"
            "16,monitor:DP-2"
            "17,monitor:DP-2"
            "18,monitor:DP-2"
            "19,monitor:DP-2"
            "20,monitor:DP-2"
          ]
        else
          [
          ];
      bind = [
        "$mainMod SHIFT, Return, exec, kitty"
        "$mainMod SHIFT, C, killactive"
        "$mainMod, P, exec, rofi-drun"
        "$mainMod, D, exec, rofi-run"
        "$mainMod, I, exec, rofi-windows"
        "$mainMod, Z, exec, rofi-pdf"
        "$mainMod SHIFT, W, exec, rofi-wallpaper"
        "$mainMod, N, exec, wifi-menu"
        "$mainMod, U, exec, uploader"
        "$mainMod SHIFT, Del, exec, pkill Hyprland"
        "$mainMod, A, togglefloating"
        "$mainMod, E, togglesplit"
        "$mainMod, F, fullscreen"
        "$mainMod,F,fullscreen"
        '',Print, exec, ${
          inputs.wayfreeze.packages.${pkgs.system}.wayfreeze
        }/bin/wayfreeze --hide-cursor & PID=$!; sleep .1; ${pkgs.grim}/bin/grim -g "$(${pkgs.slurp}/bin/slurp)" - | ${
          inputs.shadower.packages.${pkgs.system}.shadower
        }/bin/shadower | ${pkgs.wl-clipboard}/bin/wl-copy; kill $PID''
        "$mainMod, Tab, exec, ${pkgs.swaynotificationcenter}/bin/swaync-client -t"
        "$mainMod SHIFT, minus, exec, ${
          inputs.hyprcontrib.packages.${pkgs.system}.scratchpad
        }/bin/scratchpad"
        "$mainMod, minus, exec, ${inputs.hyprcontrib.packages.${pkgs.system}.scratchpad}/bin/scratchpad -g"
        "Alt_L, E, exec, hyprctl dispatch workspace +1"
        "Alt_L, Q, exec, hyprctl dispatch workspace -1"
        "$mainMod, V, exec, rofi-clipboard"
        "$mainMod, M, exec, rofi-emoji"
        "$mainMod SHIFT, Z, exec, kitty pulsemixer"
        ",XF86AudioRaiseVolume, exec, volume --up"
        ",XF86AudioLowerVolume, exec, volume --down"
        ",XF86AudioMute, exec, volume --toggle"

        "Alt_L, Tab, exec, sleep 0.1 && hyprswitch --daemon --ignore-monitors --switch-ws-on-hover"
        "Alt_L, quotedbl, exec, hyprswitch --stop-daemon"

        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"

        "$mainMod, quotedbl, exec, ${pkgs.libnotify}/bin/notify-send 'Recording saved' 'check /home/${userinfo.name}/Video'"

        "$mainMod, Q, togglegroup"
        "$mainMod, D, changegroupactive"
        "$mainMod, W, lockgroups, toggle"

        "SUPER,F10,pass,^(com\.obsproject\.Studio)$"
        "SUPER,F9,pass,^(com\.obsproject\.Studio)$"
        "SUPER,F4,pass,^(com\.obsproject\.Studio)$"
        "$mainMod, quotedbl,pass,^(com.obsproject.Studio)"
        "$mainMod, Insert,pass,^(discordcanary)$"
        "$mainMod, Home,pass,^(discordcanary)$"

        "$mainMod, 1, exec, hyprsome workspace 1"
        "$mainMod, 2, exec, hyprsome workspace 2"
        "$mainMod, 3, exec, hyprsome workspace 3"
        "$mainMod, 4, exec, hyprsome workspace 4"
        "$mainMod, 5, exec, hyprsome workspace 5"
        "$mainMod, 6, exec, hyprsome workspace 6"
        "$mainMod, 7, exec, hyprsome workspace 7"
        "$mainMod, 8, exec, hyprsome workspace 8"
        "$mainMod, 9, exec, hyprsome workspace 9"
        "$mainMod, 0, exec, hyprsome workspace 10"

        "$mainMod SHIFT, 1, exec, hyprsome move 1"
        "$mainMod SHIFT, 2, exec, hyprsome move 2"
        "$mainMod SHIFT, 3, exec, hyprsome move 3"
        "$mainMod SHIFT, 4, exec, hyprsome move 4"
        "$mainMod SHIFT, 5, exec, hyprsome move 5"
        "$mainMod SHIFT, 6, exec, hyprsome move 6"
        "$mainMod SHIFT, 7, exec, hyprsome move 7"
        "$mainMod SHIFT, 8, exec, hyprsome move 8"
        "$mainMod SHIFT, 9, exec, hyprsome move 9"
        "$mainMod SHIFT, 0, exec, hyprsome move 10"
        "$mainMod, minus, movetoworkspace, special:scratchpad"

        "$mainMod SHIFT, h, movewindow, l"
        "$mainMod SHIFT, l, movewindow, r"
        "$mainMod SHIFT, k, movewindow, u"
        "$mainMod SHIFT, j, movewindow, d"

        "$mainMod, mouse_up, workspace, r+1"
        "$mainMod, mouse_down, workspace, r-1"
      ];
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];
      bindrn = [
        "Alt_L, Tab, exec, hyprswitch --daemon --ignore-monitors --switch-ws-on-hover || hyprswitch --stop-daemon"
        "SUPER, SUPER_L, exec, pkill rofi || ${pkgs.rofi-wayland}/bin/rofi"
      ];
      input = {
        kb_layout = "us,us";
        kb_variant = ",intl";
        accel_profile = "flat";
        sensitivity = 0;
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
        };
        touchdevice = {
          transform = 1;
        };
        float_switch_override_focus = 2;
      };
      general = {
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;
        "col.active_border" = "rgb(6925FF)";
        "col.inactive_border" = "0x00000000";
        layout = "dwindle";
        resize_on_border = true;
      };
      animations = {
        enabled = true;
        bezier = [ "overshot, 0.13, 0.99, 0.29, 1.1" ];
        animation = [
          "windows, 1, 3, overshot, slide"
          "windowsOut, 1, 7, overshot, slide"
          "border, 1, 10, default"
          "fade, 0, 0, default"
          "workspaces, 0, 6, default"
        ];
      };
      decoration = {
        rounding = 0;
        drop_shadow = "yes";
        shadow_ignore_window = true;
        shadow_offset = "0 2";
        shadow_range = 20;
        shadow_render_power = 3;
        "col.shadow" = "rgba(00000055)";
        blur = {
          enabled = true;
          size = 1;
          passes = 1;
          brightness = 1;
          contrast = "1.400";
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = false;
        };
      };

      windowrulev2 = [
        "float,title:^(flameshot)"
        "move 0 -350,title:^(flameshot)"
        "suppressevent fullscreen,title:^(flameshot)"
        "noanim,title:^(flameshot)"
        "rounding 0,title:^(flameshot)"
        "monitor DP-2,title:^(flameshot)"
        "float,title:^(Firefox — Sharing Indicator)"
        "nomaxsize,title:^(winecfg)"
        "nomaxsize,class:^(steam)"
        "noanim,title:^(wlogout)"
        "float,title:^(wlogout)"
        "workspace 1, class:^(firefox)"
        "workspace 2,class:^(discord)"
        "workspace 2,class:^(vesktop)"
        "workspace 3,title:^(Steam)"
        "workspace 3,class:^(org.prismlauncher.PrismLauncher)"
        "workspace 4,class:^(mpv)"
        "workspace 5,title:^(nvim)"
        "workspace 6,class:^(krita)"
        "workspace 6,class:^(.gimp-2.10-wrapped_)"
        "workspace 7,class:^(evince)"
        "workspace 7,class:^(info.febvre.Komikku)"
        "workspace 7,class:^(Upscayl)"
        "workspace 8,class:^(obsidian)"
        "workspace 8,class:^(com.obsproject.Studio)"
        "workspace 9,class:^(Waydroid)"
        "workspace 10,class:^(steam_app*)"
        "stayfocused,class:^(Waydroid)"
        "float,initialTitle:^(Picture-in-Picture)"
        "pin,initialTitle:^(Picture-in-Picture)"
        # "forceinput,class:^(Waydroid)"
        "float,title:(pulsemixer),class:(kitty)"
        "move 25% 25%,title:(pulsemixer),class:(kitty)"
        "size 50% 50%,title:(pulsemixer),class:(kitty)"
      ];
      layerrule = [
        "noanim,rofi"
        "xray 1, wofi"
        "noanim, wayfreeze"
        "noanim, selection"
        "blur,rofi"
        "blur.notifications"
      ];
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };
      gestures = {
        workspace_swipe = true;
      };
      misc = {
        force_default_wallpaper = false;
      };
    };
    extraConfig = ''
      debug:disable_logs = false
      group {
        col.border_active = rgb(6969FF)
        col.border_inactive = rgb(4d4d4d)
        groupbar {
          col.active = rgb(6969FF)
          col.inactive = rgb(4d4d4d)
          gradients = false
          render_titles = false
        }
      }
      plugin {
          hyprbars {
              bar_height=29
              bar_text_font="JetBrainsMono Nerd Font"
              bar_text_size=13
              # config
              buttons {
                  button_size= 13
                  # button config
              }
          }
      }
      plugin {
        hy3 {
          # disable gaps when only one window is onscreen
          no_gaps_when_only = false

          # offset from group split direction when only one window is in a group
          group_inset = 10

          # tab group settings
          tabs {
            # height of the tab bar
            height = 10

            # padding between the tab bar and its focused node
            padding = 15

            # the tab bar should animate in/out from the top instead of below the window
            from_top = false

            # render the window title on the bar
            render_text = false

            # rounding of tab bar corners
            rounding = 15

            # font to render the window title with
            text_font = "Terminess Nerd Font"

            # height of the window title
            text_height = 10

            # left padding of the window title
            text_padding = 0

            # active tab bar segment color
            col.active = rgb(c8c093)

            # urgent tab bar segment color
            col.urgent = 0x4D6469

            # inactive tab bar segment color
            col.inactive = 0x4D6469

            # active tab bar text color
            col.text.active = 0x4D6469

            # urgent tab bar text color
            col.text.urgent = 0x4D6469

            # inactive tab bar text color
            col.text.inactive = 0x4D6469
          }
        }
      }
    '';
  };
}
