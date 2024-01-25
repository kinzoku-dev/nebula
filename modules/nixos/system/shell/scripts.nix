{pkgs, ...}: {
  shellpkg = pkgs.writeShellApplication {
    name = ",";
    runtimeInputs = with pkgs; [];
    text = ''
      if [ -z $1 ] then
          echo "Please provide arguments"
          exit 1
      fi
    '';
  };
}
