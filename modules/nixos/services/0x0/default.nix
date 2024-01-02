{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.OxO;
in {
  options.OxO = with types; {
    enable = mkBoolOpt false "Enable 0x0";
  };
}
