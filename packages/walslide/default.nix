{
  writeShellScriptBin,
  pkgs,
  ...
}:
writeShellScriptBin "walslide" ''
  while true; do
  ${pkgs.nitrogen}/bin/nitrogen --set-zoom-fill --random ~/.config/wallpapers --save
  sleep 600
  done
''
