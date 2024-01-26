{pkgs, ...}:
pkgs.writeShellScriptBin "shellpkg" ''
  if [ -z $1 ]; then
      echo "Please provide arguments"
      exit 1
  fi
  for var in "$@"; do
      echo "Adding package $var"
      nix shell nixpkgs#$var
  done
''
