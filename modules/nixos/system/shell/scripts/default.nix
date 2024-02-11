{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  shellpkg = import ./shellpkg.nix {inherit pkgs;};
in {
  environment.systemPackages = with pkgs; [
    shellpkg
  ];
}
