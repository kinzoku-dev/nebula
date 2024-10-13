{
  userinfo,
  pkgs,
  lib,
  ...
}:
let
  sshPubkeys = pkgs.fetchurl {
    url = "https://github.com/kinzoku-dev.keys";
    hash = "0jd8fp4qw9wnhw0iw0dp7riid5pcxfy07d17mp0z53cvzfrbqkh1";
  };
in
{
  services.openssh = {
    enable = true;
    allowSFTP = true;
    settings = {
      # disable ssh password auth
      PasswordAuthentication = false;
    };
  };

  users.users = {
    ${userinfo.name}.openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile sshPubkeys);
    root.openssh.authorizedKeys.keys = lib.splitString "\n" (builtins.readFile sshPubkeys);
  };
}
