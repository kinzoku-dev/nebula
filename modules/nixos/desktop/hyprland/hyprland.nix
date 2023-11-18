{
  monitorList,
  pkgs,
}: ''
  ${monitorList}
  exec-once=${pkgs.nebula.nebulauncher}/bin/nebulauncher --launch waybar
  exec-once=swww init &
  exec-once=swww img ~/.config/wallpapers/ultra1.png &
  exec-once=mako &
  exec-once=xwaylandvideobridge
  exec-once=nm-applet

  decoration {
      rounding = 10

      drop_shadow = yes
      shadow_range = 4
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)
  }
  general {
      border_size = 3
      layout = dwindle
      gaps_in = 5
      gaps_out = 20
  }

  input {
      kb_options = caps:escape
  }

  dwindle {
    preserve_split = yes
  }

  $mainMod = ALT

  bind = $mainMod SHIFT, Return, exec, foot
  bind = $mainMod SHIFT, C, killactive
  bind = $mainMod, P, exec, anyrun
  bind = $mainMod SHIFT, S, exec, grim -l 0 -g "$(slurp)" - | wl-copy
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

  bindm = $mainMod, mouse:272, movewindow
  bindm = $mainMod, mouse:273, resizewindow
''
