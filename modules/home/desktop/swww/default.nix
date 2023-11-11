{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.home.desktop.swww;
in {
  options.home.desktop.swww = with types; {
    enable = mkBoolOpt false "Enable SWWW wallpaper daemon";
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.swww
      (pkgs.writeShellScriptBin "wallpaper" ''
        /usr/bin/env ls ~/.config/wallpapers/ | sort -R | tail -1 |while read file; do
            swww img ~/.config/wallpapers/$file --transition-fps 255 --transition-type wipe
            echo "~/.config/wallpapers/$file"
        done
      '')
    ];
  };
}
