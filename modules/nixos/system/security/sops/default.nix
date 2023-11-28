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
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  config = {
    sops.defaultSopsFile = ./secrets/secrets.yaml;
    sops.defaultSopsFormat = "yaml";

    sops.age.keyFile = "/home/${config.user.name}/.config/sops/age/keys.txt";

    sops.secrets.example-key = {};
    sops.secrets."myservice/my_subdir/my_secret" = {};
  };
}
