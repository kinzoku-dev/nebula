{
  config,
  pkgs,
  lib,
  options,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.wine;
in {
  options.apps.wine = with types; {
    enable = mkBoolOpt false "Enable wine";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        wineWowPackages.stagingFull
        winetricks
      ];
      persist.home.directories = [
        ".local/share/wineprefixes"
        ".wine"
      ];
    };
  };
}
