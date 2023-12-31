{
  displayList,
  workspaceMonitors,
  pkgs,
  colors,
}: ''
  ${displayList}
  exec-once=waybar &
  exec-once=swww init &
  exec-once=swww img ~/Pictures/invasion_of_vryn_purple.jpg &
  exec-once=mako &
  exec-once=nm-applet
  exec-once=blueman-applet

  decoration {
      rounding = 10

      drop_shadow = yes
      shadow_range = 4
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)
      blur {
          size = 5
          passes = 3
          new_optimizations = true
          xray = false
      }
  }
  env = WLR_NO_HARDWARE_CURSORS,1
  env = GTK_THEME,Catppuccin-Mocha-Compact-Lavender-Dark
  env = WLR_DRM_NO_ATOMIC,1

  plugin {
      split-monitor-workspaces {
          count = 10
      }
  }

  general {
      border_size = 3
      layout = dwindle
      gaps_in = 5
      gaps_out = 10
      col.active_border = rgb(${colors.base0E}) rgb(${colors.base0E}) rgb(${colors.base07}) rgb(${colors.base0D}) 45deg
      col.inactive_border = rgb(${colors.base02})
  }

  input {
      kb_options = caps:escape,grp:win_space_toggle
      kb_layout = us,us,us
      kb_variant = ,intl,colemak_dh
  }

  dwindle {
    preserve_split = yes
  }

  $mainMod = ALT

  bind = $mainMod SHIFT, Return, exec, kitty
  bind = $mainMod SHIFT, C, killactive
  bind = $mainMod, P, exec, anyrun
  bind = $mainMod SHIFT, S, exec, grimblast --freeze copy area
  bind = $mainMod, V, togglefloating

  binde =, Prior, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%+
  binde =, Next, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SINK@ 5%-
  bind =, End, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

  binde = $mainMod, Prior, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SOURCE@ 5%+
  binde = $mainMod, Next, exec, wpctl set-volume -l 1.4 @DEFAULT_AUDIO_SOURCE@ 5%-
  bind = $mainMod, End, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

  # Move focus with mainMod + arrow keys
  bind = $mainMod, h, movefocus, l
  bind = $mainMod, l, movefocus, r
  bind = $mainMod, k, movefocus, u
  bind = $mainMod, j, movefocus, d

  # Move window with mainMod_SHIFT + arrow keys
  bind = $mainMod SHIFT, h, movewindow, l
  bind = $mainMod SHIFT, l, movewindow, r
  bind = $mainMod SHIFT, k, movewindow, u
  bind = $mainMod SHIFT, j, movewindow, d

  bind = $mainMod, R, submap, resize

  submap=resize

  binde =, h, resizeactive, -15 0
  binde =, l, resizeactive, 15 0
  binde =, k, resizeactive, 0 -15
  binde =, j, resizeactive, 0 15

  bind =, escape, submap, reset

  submap=reset

  bind = $mainMod, 1, split-workspace, 1
  bind = $mainMod, 2, split-workspace, 2
  bind = $mainMod, 3, split-workspace, 3
  bind = $mainMod, 4, split-workspace, 4
  bind = $mainMod, 5, split-workspace, 5
  bind = $mainMod, 6, split-workspace, 6
  bind = $mainMod, 7, split-workspace, 7
  bind = $mainMod, 8, split-workspace, 8
  bind = $mainMod, 9, split-workspace, 9
  bind = $mainMod, 0, split-workspace, 10

  bind = $mainMod SHIFT, 1, split-movetoworkspacesilent, 1
  bind = $mainMod SHIFT, 2, split-movetoworkspacesilent, 2
  bind = $mainMod SHIFT, 3, split-movetoworkspacesilent, 3
  bind = $mainMod SHIFT, 4, split-movetoworkspacesilent, 4
  bind = $mainMod SHIFT, 5, split-movetoworkspacesilent, 5
  bind = $mainMod SHIFT, 6, split-movetoworkspacesilent, 6
  bind = $mainMod SHIFT, 7, split-movetoworkspacesilent, 7
  bind = $mainMod SHIFT, 8, split-movetoworkspacesilent, 8
  bind = $mainMod SHIFT, 9, split-movetoworkspacesilent, 9
  bind = $mainMod SHIFT, 0, split-movetoworkspacesilent, 10

  bind = SUPER SHIFT, J, split-changemonitorsilent, prev
  bind = SUPER SHIFT, K, split-changemonitorsilent, next

  bindm = $mainMod, mouse:273, resizewindow

  ${workspaceMonitors}
''
