{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.ssh;
in {
  options.system.ssh = with types; {
    enable = mkBoolOpt false "Enable ssh";
    port = mkOpt int 22 "SSH port";
  };

  config = mkIf cfg.enable {
    users = {
      mutableUsers = false;
      users.root.initialPassword = "wigglenuts123";
      users.${config.user.name}.openssh.authorizedKeys = {
        keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINGKJjalzFloqAZdQDQKalAdU+flocszBXk48DbZXtHQ kinzoku@the-nebula.xyz"
        ];
      };
    };
    services.openssh = {
      enable = true;
      passwordAuthentication = false;
      challengeResponseAuthentication = false;
      ports = [
        cfg.port
      ];
      extraConfig = ''
        AllowTcpForwarding yes
        X11Forwarding no
        AllowAgentForwarding no
        AllowStreamLocalForwarding no
        AuthenticationMethods publickey
      '';
    };
    system.persist.home.dirs = [
      ".ssh"
    ];
  };
}
