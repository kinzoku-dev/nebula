{
  config,
  lib,
  options,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.impermanence;
in {
  options.system.impermanence = with types; {
    enable = mkBoolOpt false "Enable impermanence";
  };

  config = mkIf cfg.enable {
    fileSystems."/persist".neededForBoot = true;
    environment.persistence."/persist/system" = {
      hideMounts = true;
      directories = [
        "/etc/nixos"
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        {
          directory = "/var/lib/colord";
          user = "colord";
          group = "colord";
          mode = "u=rwx,g=rx,o=";
        }
      ];
      files = [
        "/etc/machine-id"
        {
          file = "/var/keys/secret_file";
          parentDirectory = {mode = "u=rwx,g=,o=";};
        }
      ];
    };
    home.extraOptions.persistence."/persist/home" = {
      directories = [
        "Downloads"
        "Audio"
        "Video"
        "Images"
        "Dev"
        ".gnupg"
        ".ssh"
        ".local/share/keyrings"
        ".local/share/direnv"
        ".mozilla"
        ".nebula"
        {
          directory = ".local/share/Steam";
          method = "symlink";
        }
      ];
      files = [
        ".screenrc"
      ];
      allowOther = true;
    };
  };
}
