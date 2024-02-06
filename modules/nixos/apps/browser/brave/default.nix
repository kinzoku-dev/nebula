{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  browserCfg = config.apps.browser;
  braveEnabled = let
    found = lib.lists.findFirstIndex (x: x == "brave") null browserCfg.enable;
  in
    if found == "brave"
    then true
    else false;
in {
  config = mkIf braveEnabled {
    environment.systemPackages = [pkgs.brave];
  };
}
