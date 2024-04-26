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

  imports = [inputs.sops-nix.nixosModules.sops];

  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = ./secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age = {
        sshKeyPaths = ["/home/${config.user.name}/.ssh/id_ed25519"];

        keyFile = "/home/${config.user.name}/.config/sops/age/keys.txt";

        generateKey = true;
      };
      secrets = {
        cloudflared-token = {};
        nextcloud-admin-pass = {};
        invidious-hmac-key = {};
      };
    };
  };
}
