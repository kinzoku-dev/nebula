{
  config,
  pkgs,
  lib,
  options,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.obsidian;
in {
  options.apps.obsidian = with types; {
    enable = mkBoolOpt false "Enable Obsidian for note-taking";
    sync = mkBoolOpt false "Enable syncing for obsidian vaults";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      obsidian
    ];
  };
}
