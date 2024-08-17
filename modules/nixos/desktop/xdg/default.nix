{
  config,
  options,
  pkgs,
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
        homeDir = config.home.extraOptions.home.homeDirectory;
      in {
        enable = true;
        createDirectories = true;
        desktop = "${homeDir}/Desktop";
        documents = "${homeDir}/Documents";
        download = "${homeDir}/Downloads";
        music = "${homeDir}/Audio";
        videos = "${homeDir}/Video";
        pictures = "${homeDir}/Images";
        extraConfig = {
          XDG_DEV_DIR = "${homeDir}/Dev";
          XDG_NOTES_DIR = "${homeDir}/Notes";
          XDG_MOUNTS_DIR = "${homeDir}/Mounts";
        };
      };
    };
    environment.persist.home.directories = [
      "Desktop"
      "Documents"
      "Downloads"
      "Audio"
      "Video"
      "Images"
      "Dev"
      "Notes"
      "Mounts"
    ];
  };
}
