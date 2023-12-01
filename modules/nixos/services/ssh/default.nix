{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.services.ssh;
in {
  options.services.ssh = with types; {
    enable = mkBoolOpt false "Enable ssh";
    extraConfig = mkOpt lines "" "extra config";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
      ports = [22];
    };

    users.users = {
      root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINGKJjalzFloqAZdQDQKalAdU+flocszBXk48DbZXtHQ kinzokudev4869@gmail.com"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBQBLgsHBT+XIna7j0TWocmEsoksvphIZGf8x6h7JMqh kinzoku@tempest"
      ];
      ${config.user.name}.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINGKJjalzFloqAZdQDQKalAdU+flocszBXk48DbZXtHQ kinzokudev4869@gmail.com"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBQBLgsHBT+XIna7j0TWocmEsoksvphIZGf8x6h7JMqh kinzoku@tempest"
      ];
    };

    home.file.".ssh/config".text = ''
      identityfile ~/.ssh/id_ed25519

      ${cfg.extraConfig}
    '';
  };
}
