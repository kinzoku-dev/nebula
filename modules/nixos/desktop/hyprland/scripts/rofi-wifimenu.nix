{pkgs, ...}:
pkgs.writeShellScriptBin "wifi-menu" ''
  bssid=$( ${pkgs.networkmanager}/bin/nmcli dev wifi list | sed -n '1!p' | cut -b 9- | ${pkgs.rofi}/bin/rofi -dmenu -theme ~/.config/rofi/wifi-menu/style-1.rasi -p "󰖩" | cut -d' ' -f1)

  [ -z "$bssid" ] && exit

  password=$(echo "" | ${pkgs.rofi}/bin/rofi -dmenu -theme ~/.config/rofi/wifi-menu/wifi-password.rasi -p "󰷖" )

  [ -z "$password" ] && exit

  icon=${./.}/icons/wifi-icon.png
  iconE=${./.}/icons/error-warning.png

  notify_connect() {
      status=$(echo $?)
      wifi_network=$( ${pkgs.networkmanager}/bin/nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\' -f2 | sed 's/^[^:]*://')

      if [[ "$status" == '0' ]]; then
          ${pkgs.dunst}/bin/dunstify -u low --replace=69 -i "$icon" "Connected to Network: $wifi_network"
      elif [[ "$status" -gt '0' ]]; then
          ${pkgs.dunst}/bin/dunstify -u low --replace=69 -i "$iconE" "Unable to Connect: Incorrect Passphrase"
      fi
  }

  ${pkgs.networkmanager}/bin/nmcli device wifi connect $bssid password $password ; notify_connect

''
