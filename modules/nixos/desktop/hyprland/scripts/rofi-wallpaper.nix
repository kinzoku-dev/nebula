{pkgs, ...}:
pkgs.writeShellApplication {
  name = "rofi-wallpaper";
  runtimeInputs = with pkgs; [rofi-wayland swww dunst];
  text = ''
    wallpapers="$HOME/.config/wallpapers/"
    dir="$HOME/.config/rofi/launchers/wallpaper-selector"
    theme='style-1'

    list_wallpapers() {
        for file in "$1"/*
        do
            if [[ -f "$file" ]]; then
                echo -en "$(basename "$file")\0icon\x1f$(realpath "$file")\n"
            fi
        done
    }

    selected_wallpaper="$(list_wallpapers "''${wallpapers}" |  rofi -dmenu -theme "''${dir}"/"''${theme}".rasi -p "󰥶")"

    icon="''${wallpapers}""''${selected_wallpaper}"

    if [[ -f "$selected_wallpaper" ]]; then
        exit 0;
    fi


    swww img "''${wallpapers}""''${selected_wallpaper}" && dunstify -u low --replace=69 -i "''${icon}" "Wallpaper Changed"
  '';
}
