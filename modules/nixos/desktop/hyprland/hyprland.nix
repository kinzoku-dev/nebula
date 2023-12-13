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

  general {
      border_size = 3
      layout = dwindle
      gaps_in = 5
      gaps_out = 10
      col.active_border = rgb(${colors.base0E}) rgb(${colors.base0E}) rgb(${colors.base07}) rgb(${colors.base0D}) 45deg
      col.inactive_border = rgb(${colors.base02})
  }

  input {
      kb_options = caps:escape,grp:alt_shift_k_toggle
      kb_layout = us,us
      kb_variant = ,intl
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

  bind = $mainMod, 1, workspace, 1
  bind = $mainMod, 2, workspace, 2
  bind = $mainMod, 3, workspace, 3
  bind = $mainMod, 4, workspace, 4
  bind = $mainMod, 5, workspace, 5
  bind = $mainMod, 6, workspace, 6
  bind = $mainMod, 7, workspace, 7
  bind = $mainMod, 8, workspace, 8
  bind = $mainMod, 9, workspace, 9
  bind = $mainMod, 0, workspace, 10
  bind = SUPER, 1, workspace, 11
  bind = SUPER, 2, workspace, 12
  bind = SUPER, 3, workspace, 13
  bind = SUPER, 4, workspace, 14
  bind = SUPER, 5, workspace, 15
  bind = SUPER, 6, workspace, 16
  bind = SUPER, 7, workspace, 17
  bind = SUPER, 8, workspace, 18
  bind = SUPER, 9, workspace, 19
  bind = SUPER, 0, workspace, 20

  bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
  bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
  bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
  bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
  bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
  bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
  bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
  bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
  bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
  bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10
  bind = SUPER SHIFT, 1, movetoworkspacesilent, 11
  bind = SUPER SHIFT, 2, movetoworkspacesilent, 12
  bind = SUPER SHIFT, 3, movetoworkspacesilent, 13
  bind = SUPER SHIFT, 4, movetoworkspacesilent, 14
  bind = SUPER SHIFT, 5, movetoworkspacesilent, 15
  bind = SUPER SHIFT, 6, movetoworkspacesilent, 16
  bind = SUPER SHIFT, 7, movetoworkspacesilent, 17
  bind = SUPER SHIFT, 8, movetoworkspacesilent, 18
  bind = SUPER SHIFT, 9, movetoworkspacesilent, 19
  bind = SUPER SHIFT, 0, movetoworkspacesilent, 20

  bindm = $mainMod, mouse:273, resizewindow

  ${workspaceMonitors}
''
