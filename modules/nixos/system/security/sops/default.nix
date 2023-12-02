{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.security.sops;
in {
  options.security.sops = with types; {
    enable = mkBoolOpt false "Enable sops";
  };

  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  config = mkIf cfg.enable {
    sops.defaultSopsFile = ./secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.age.sshKeyPaths = ["/home/${config.user.name}/.ssh/id_ed25519"];

    sops.age.keyFile = "/home/${config.user.name}/.config/sops/age/keys.txt";

    sops.age.generateKey = true;

    sops.secrets.cloudflared-token = {};
    sops.secrets.invHmacKey = {};
  };
}
