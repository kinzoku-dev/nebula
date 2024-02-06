{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; {
  config =
    /*
    mkIf librewolfEnabled
    */
    {
      environment.systemPackages = [pkgs.librewolf];
    };
}
