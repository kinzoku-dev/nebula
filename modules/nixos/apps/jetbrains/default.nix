{
  pkgs,
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.jetbrains;
in {
  options.apps.jetbrains = with types; {
    enable = mkBoolOpt false "Enable JetBrains IDEs";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      jetbrains.idea-community
      jetbrains.idea-ultimate
    ];
  };
}
