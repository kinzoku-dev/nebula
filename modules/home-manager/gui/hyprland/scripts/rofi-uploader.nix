{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "uploader";
  runtimeInputs = with pkgs; [
    fd
    curl
    rofi-wayland
    dunst
    wl-clipboard
  ];
  text = ''
    dir="$HOME/.config/rofi/launchers/type-1"
    theme='style-1'
    file=$(fd --full-path "$HOME" -t f | rofi -dmenu -theme "''${dir}"/"''${theme}".rasi -p "󰍜")
    url=$(curl -F "file=@$file" https://0x0.banana.is-cool.dev/)
    wl-copy "$url"
    dunstify -u low --replace=69 "File has been uploaded to URL $url"
  '';
}
