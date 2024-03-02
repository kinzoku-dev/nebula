{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) colors;
  browserCfg = config.apps.browser;
  firefoxEnabled = let
    found = lib.lists.findFirstIndex (x: x == "firefox") null browserCfg.enable;
  in
    if found == "firefox"
    then true
    else false;
in {
  config = {
  };
}
