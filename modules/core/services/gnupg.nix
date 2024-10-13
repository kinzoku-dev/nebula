{
  pkgs,
  config,
  ...
}:
{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-curses;
  };
  environment = {
    systemPackages = with pkgs; [
      pinentry
      pinentry-curses
    ];
    variables = {
      GNUPGHOME = "${config.hm.xdg.dataHome}/.gnupg";
    };
  };
  hm.home.file.".local/share/.gnupg/gpg-agent.conf".text = ''
    pinentry-program /run/current-system/sw/bin/pinentry-curses
  '';
}
