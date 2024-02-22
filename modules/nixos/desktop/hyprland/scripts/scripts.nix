{pkgs, ...}: {
  volume = pkgs.writeShellApplication {
    name = "volume";
    runtimeInputs = with pkgs; [pamixer dunst];
    text = ''
      icon_dir=${./.}/icons

      get_volume() {
          volume=$(pamixer --get-volume)
          echo "$volume"
      }

      get_icon() {
          vol="$(get_volume)"
          current="''${vol%%%}"
          if [[ "$current" -eq "0" ]]; then
            icon="''${icon_dir}"/volume_muted.svg
          elif [[ ("$current" -gt "0") && ("$current" -le "30") ]]; then
            icon="''${icon_dir}"/volume_low.svg
          elif [[ ("$current" -gt "30") && ("$current" -le "60") ]]; then
            icon="''${icon_dir}"/volume_medium.svg
          elif [[ ("$current" -gt "60") && ("$current" -le "90") ]]; then
            icon="''${icon_dir}"/volume_high.svg
          elif [[ ("$current" -gt "90") && ("$current" -le "100") ]]; then
            icon="''${icon_dir}"/volume_overamplified.svg
          fi
      }

      up_volume() {
          pamixer -i 5 --unmute && get_icon && dunstify -u low --replace=69 -i "$icon" "Volume : $(get_volume)%"
      }

      down_volume() {
          pamixer -d 5 --unmute && get_icon && dunstify -u low --replace=69 -i "$icon" "Volume : $(get_volume)%"
      }

      toggle_mute() {
          status=$(pamixer --get-mute)
          if [[ "$status" == "true" ]]; then
              pamixer --unmute && get_icon && dunstify -u low --replace=69 -i "$icon" "Unmuted"
          else
              pamixer --mute && dunstify -u low --replace=69 -i "''${icon_dir}"/volume_muted.svg "Muted"
          fi
      }

      case "$1" in
        "--get")
            get_volume
            ;;
        "--up")
            up_volume
            ;;
        "--down")
            down_volume
            ;;
        "--toggle")
            toggle_mute
            ;;
        *)
            get_volume
            ;;
      esac
    '';
  };

  power-menu = pkgs.writeShellApplication {
    name = "powermenu";
    runtimeInputs = with pkgs; [swaylock-effects rofi];
    text = ''
                   dir="$HOME/.config/rofi/powermenu"
                   theme='style-1'

                   shutdown='⏻ Shutdown'
                   reboot=' Reboot'
                   lock='󰌾 Lock'
                   suspend='󰤄 Suspend'
                   logout='󰍃 Logout'
                   yes=' Yes'
                   no='  No'

                   rofi_cmd() {
                       rofi -dmenu \
                         -p "Powermenu" \
                         -theme "''${dir}"/"''${theme}".rasi
                   }

                   confirm_cmd() {
                      rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 250px;}' \
                   -theme-str 'mainbox {children: [ "message", "listview" ];}' \
                   -theme-str 'listview {columns: 2; lines: 1;}' \
                   -theme-str 'element-text {horizontal-align: 0.5;}' \
                   -theme-str 'textbox {horizontal-align: 0.5;}' \
                   -dmenu \
                   -p 'Confirmation' \
                      -mesg 'Are you Sure?' \
                   -theme "''${dir}"/"''${theme}".rasi
                   }

                   confirm_exit() {
                  echo -e "$yes\n$no" | confirm_cmd
                   }

                   run_rofi() {
                     echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi_cmd
                   }

                   run_cmd() {
            	selected="$(confirm_exit)"
            	if [[ "$selected" == "$yes" ]]; then
            		if [[ $1 == '--shutdown' ]]; then
            			systemctl poweroff
            		elif [[ $1 == '--reboot' ]]; then
            			systemctl reboot
            		elif [[ $1 == '--suspend' ]]; then
            		    swaylock
            		elif [[ $1 == '--logout' ]]; then
            			if [[ "$DESKTOP_SESSION" == 'openbox' ]]; then
            				openbox --exit
            			elif [[ "$DESKTOP_SESSION" == 'bspwm' ]]; then
            				bspc quit
            			elif [[ "$DESKTOP_SESSION" == 'i3' ]]; then
            				i3-msg exit
            			elif [[ "$DESKTOP_SESSION" == 'plasma' ]]; then
            				qdbus org.kde.ksmserver /KSMServer logout 0 0 0
            			fi
            		fi
            	else
            		exit 0
            	fi
            }

            chosen="$(run_rofi)"
      case "''${chosen}" in
          "$shutdown")
      		run_cmd --shutdown
              ;;
          "$reboot")
      		run_cmd --reboot
              ;;
          "$lock")
      		if [[ -x '/usr/bin/betterlockscreen' ]]; then
      			betterlockscreen -l
      		elif [[ -x '/usr/bin/i3lock' ]]; then
      			i3lock
      		fi
              ;;
          "$suspend")
      		run_cmd --suspend
              ;;
          "$logout")
      		run_cmd --logout
              ;;
      esac
    '';
  };
  emoji = pkgs.writeShellApplication {
    name = "emoji";
    runtimeInputs = with pkgs; [rofi-emoji];
    text = ''
      dir="$HOME/.config/rofi/emoji"
      theme='style-1'

      rofi \
      -modi emoji \
      -show emoji \
      -theme "''${dir}"/"''${theme}".rasi
    '';
  };
  rofi-clipboard = pkgs.writeShellApplication {
    name = "rofi-clipboard";
    runtimeInputs = with pkgs; [rofi-wayland wl-clipboard cliphist];
    text = ''
      dir="$HOME/.config/rofi/clipboard"
      theme='style-1'

      cliphist list | rofi -dmenu -theme "''${dir}"/"''${theme}".rasi -p "󰅌" | cliphist decode | wl-copy
    '';
  };
}
