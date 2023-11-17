{
  writeShellScriptBin,
  pkgs,
}:
writeShellScriptBin "nebulauncher" ''
  if [ -z "$1" ]; then
      echo "Please provide an option"
  else
      if [ -n "$2" ]; then
        if [ $1 == "--launch" ] ; then
            case $2 in
                waybar)
                    ${pkgs.waybar}/bin/waybar & disown;;
                *)
                    echo "test";;
            esac
        elif [ $1 == "--reload" ]; then
            case $2 in
                waybar)
                    ${pkgs.busybox}/bin/pkill waybar
                    ${pkgs.waybar}/bin/waybar & disown;;
                *)
                    echo "test";;
            esac
        fi
      else
          echo "error"
      fi
  fi
''
