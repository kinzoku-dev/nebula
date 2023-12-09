{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.qbittorrent;
in {
  options.qbittorrent = with types; {
    enable = mkBoolOpt false "Enable qbittorrent";
  };

  config = mkIf cfg.enable {
    # TODO: add qbittorrent config
  };
}
