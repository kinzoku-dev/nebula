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
    environment.systemPackages = [pkgs.pinentry pkgs.pinentry-curses];

    services.pcscd.enable = true;
    programs.gnupg.agent = {
      enable = true;
      pinentryFlavor = "curses";
      enableSSHSupport = true;
    };

    home.file.".local/share/gnupg/gpg-agent.conf".source = ./gpg-agent.conf;

    environment.sessionVariables = {
      GNUPGHOME = "/home/${config.user.name}/.local/share/gnupg";
    };
  };
}
