{
  config,
  pkgs,
  lib,
  options,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.zellij;
in {
  options.apps.zellij = with types; {
    enable = mkBoolOpt false "Enable zellij";
  };
}
