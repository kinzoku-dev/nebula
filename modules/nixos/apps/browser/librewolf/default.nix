{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  browserCfg = config.apps.browser;
  librewolfEnabled = let
    found = lib.lists.findFirstIndex (x: x == "librewolf") null browserCfg.enable;
  in
    if found == "librewolf"
    then true
    else false;
in {
  config =
    /*
    mkIf librewolfEnabled
    */
    {
      environment.systemPackages = [pkgs.librewolf];
    };
}
