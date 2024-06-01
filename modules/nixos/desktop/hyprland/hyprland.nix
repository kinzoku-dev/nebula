{
  displayList,
  workspaceMonitors,
  pkgs,
  config,
  colors,
}: ''
  ${displayList}
  exec-once=waybar &
  exec-once=swww init &
  exec-once=swww img /home/${config.user.name}/.config/wallpapers/$(env ls /home/${config.user.name}/.config/wallpapers | shuf -n 1) &
  exec-once=dunst &
  exec-once=nm-applet &
  exec-once=blueman-applet &
  exec-once=wl-paste --watch cliphist store &
  exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
  exec-once=premid &

  decoration {
      rounding = 0

      drop_shadow = yes

      shadow_ignore_window = true
      shadow_offset = 0 2
      shadow_range = 20
      shadow_render_power = 3
      col.shadow = rgba(00000055)
      blur {
          enabled = true
          size = 1
          passes = 1
          brightness = 1
          contrast = 1.400
          ignore_opacity = true
          noise = 0
          new_optimizations = true
          xray = false
      }
  }
  layerrule = blur,rofi
  layerrule = blur,notifications
  windowrulev2 = float,title:(pulsemixer),class:(kitty)
  windowrulev2 = move 25% 25%,title:(pulsemixer),class:(kitty)
  windowrulev2 = size 50% 50%,title:(pulsemixer),class:(kitty)
  env = WLR_NO_HARDWARE_CURSORS,1
  env = GTK_THEME,Catppuccin-Mocha-Compact-Lavender-Dark
  env = WLR_DRM_NO_ATOMIC,1

  gestures {
      workspace_swipe = true
  }

  general {
      border_size = 2
      layout = dwindle
      gaps_in = 5
      gaps_out = 10
      col.active_border = rgb(${colors.base07})
      col.inactive_border = 0x00000000
  }

  input {
      kb_options = caps:escape,grp:win_space_toggle
      kb_layout = us,us,us
      kb_variant = ,intl,colemak_dh
      accel_profile = flat
      sensitivity = 0.6
  }

  dwindle {
    preserve_split = yes
  }

  $mainMod = SUPER

  bind = $mainMod SHIFT, Return, exec, kitty
  bind = $mainMod SHIFT, C, killactive
  bind = $mainMod, P, exec, rofi-drun
  bind = $mainMod SHIFT, P, exec, powermenu
  bind = $mainMod, D, exec, rofi-run
  bind = $mainMod, W, exec, rofi-windows
  bind = $mainMod, Z, exec, rofi-pdf
  bind = $mainMod SHIFT, W, exec, rofi-wallpaper
  bind = $mainMod, N, exec, wifi-menu
  bind = $mainMod, U, exec, uploader
  bind = $mainMod SHIFT, S, exec, grimblast copy  area --freeze
  bind = $mainMod, V, togglefloating
  bind = $mainMod, C, exec, hyprpicker | wl-copy
  bind = $mainMod, T, togglegroup
  bind = $mainMod, M, exec, rofi-calculate
  bind = $mainMod, E, exec, emoji
  bind = $mainMod, B, exec, rofi-clipboard
  bind = $mainMod SHIFT, Z, exec, kitty pulsemixer
  bind = $mainMod, F, fullscreen

  bind = ,XF86AudioRaiseVolume, exec, volume --up
  bind = ,XF86AudioLowerVolume, exec, volume --down
  bind = ,XF86AudioMute, exec, volume --toggle

  # Move focus with mainMod + arrow keys
  bind = $mainMod, h, movefocus, l
  bind = $mainMod, l, movefocus, r
  bind = $mainMod, k, movefocus, u
  bind = $mainMod, j, movefocus, d

  bind = $mainMod SHIFT, h, movewindoworgroup, l
  bind = $mainMod SHIFT, l, movewindoworgroup, r
  bind = $mainMod SHIFT, k, movewindoworgroup, u
  bind = $mainMod SHIFT, j, movewindoworgroup, d

  bind = ALT SHIFT, J, changegroupactive, b
  bind = ALT SHIFT, K, changegroupactive, f
  bind = ALT SHIFT, H, movegroupwindow, b
  bind = ALT SHIFT, L, movegroupwindow, f

  # Move window with mainMod_SHIFT + arrow keys
  bind = $mainMod, R, submap, resize

  submap=resize

  binde =, h, resizeactive, -15 0
  binde =, l, resizeactive, 15 0
  binde =, k, resizeactive, 0 -15
  binde =, j, resizeactive, 0 15

  bind =, escape, submap, reset

  submap=reset

  bind = $mainMod, 1, exec, hyprsome workspace 1
  bind = $mainMod, 2, exec, hyprsome workspace 2
  bind = $mainMod, 3, exec, hyprsome workspace 3
  bind = $mainMod, 4, exec, hyprsome workspace 4
  bind = $mainMod, 5, exec, hyprsome workspace 5
  bind = $mainMod, 6, exec, hyprsome workspace 6
  bind = $mainMod, 7, exec, hyprsome workspace 7
  bind = $mainMod, 8, exec, hyprsome workspace 8
  bind = $mainMod, 9, exec, hyprsome workspace 9
  bind = $mainMod, 0, exec, hyprsome workspace 10

  bind = $mainMod SHIFT, 1, exec, hyprsome move 1
  bind = $mainMod SHIFT, 2, exec, hyprsome move 2
  bind = $mainMod SHIFT, 3, exec, hyprsome move 3
  bind = $mainMod SHIFT, 4, exec, hyprsome move 4
  bind = $mainMod SHIFT, 5, exec, hyprsome move 5
  bind = $mainMod SHIFT, 6, exec, hyprsome move 6
  bind = $mainMod SHIFT, 7, exec, hyprsome move 7
  bind = $mainMod SHIFT, 8, exec, hyprsome move 8
  bind = $mainMod SHIFT, 9, exec, hyprsome move 9
  bind = $mainMod SHIFT, 0, exec, hyprsome move 10

  bindm = $mainMod, mouse:272, movewindow
  bindm = $mainMod, mouse:273, resizewindow

  ${workspaceMonitors}
''
# split-monitor-workspaces {
#     count = 10
# }

