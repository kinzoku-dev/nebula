{
  writeShellScriptBin,
  pkgs,
}:
writeShellScriptBin "wallpaper" ''
  /usr/bin/env ls /home/kinzoku/.config/wallpapers/ | sort -R | tail -1 |while read file; do
      ${pkgs.swww}/bin/swww img /home/kinzoku/.config/wallpapers/$file --transition-fps 255 --transition-type wipe
      echo "/home/kinzoku/.config/wallpapers/$file"
  done
''
