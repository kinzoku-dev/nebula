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
  cfg = config.system.sops;
in {
  options.system.sops = with types; {
    enable = mkBoolOpt false "Enable sops-nix for secret management";
  };

  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  config = mkIf cfg.enable {
    sops.defaultSopsFile = ./secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.age.keyFile = "/home/${config.user.name}/.config/sops/age/keys.txt";

    sops.secrets.example-key = {};
    sops.secrets."myservice/my_subdir/my_secret" = {};
  };
}
