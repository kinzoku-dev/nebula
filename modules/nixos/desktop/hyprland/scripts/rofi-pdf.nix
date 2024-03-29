{pkgs, ...}:
pkgs.writeShellApplication {
  name = "rofi-pdf";
  runtimeInputs = with pkgs; [zathura findutils rofi-wayland];
  text = ''
    dir="$HOME/.config/rofi/launchers/pdf-launcher"
    theme='style-1'

    book_directory="$HOME/Documents/Books"
    selected=$(find "''${book_directory}" -path "''${book_directory}"/.git -prune -o -mindepth 1 -printf '%P\n' -iname ".pdf"  | rofi -dmenu -theme "''${dir}"/"''${theme}".rasi drun -display-drun -p " ")

    [ -z "$selected" ] && exit

    zathura "''${book_directory}"/"''${selected}"
  '';
}
