{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.security.gnupg;
in {
  options.system.security.gnupg = with types; {
    enable = mkBoolOpt false "Enable gnupg";
  };

  config = mkIf cfg.enable {
    services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      pinentryPackage = pkgs.pinentry-curses;
      enableSSHSupport = true;
    };
    system.persist.home.dirs = [
      ".gnupg"
      ".local/share/gnupg"
    ];
    environment = {
      systemPackages = [pkgs.pinentry pkgs.pinentry-curses];

      sessionVariables = {
        GNUPGHOME = "/home/${config.user.name}/.local/share/gnupg";
      };
    };

    home.file.".local/share/gnupg/gpg-agent.conf".source = ./gpg-agent.conf;
  };
}
