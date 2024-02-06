{
  config,
  options,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.desktop.xdg;
in {
  options.desktop.xdg = with types; {
    enable = mkBoolOpt false "Enable xdg desktop stuff";
  };

  config = mkIf cfg.enable {
    home.extraOptions.xdg = {
      userDirs = let
        homeDir = config.home.homeDirectory;
      in {
        enable = true;
        createDirectories = true;
        desktop = "${homeDir}/Desktop";
        documents = "${homeDir}/Dev";
        download = "${homeDir}/Downloads";
        music = "${homeDir}/Audio";
        videos = "${homeDir}/Video";
        pictures = "${homeDir}/Images";
      };
    };
  };
}
