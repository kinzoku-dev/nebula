{
  config,
  pkgs,
  lib,
  inputs,
  options,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.security.sops;
in {
  # imports = with inputs; [
  #   sops-nix.nixosModules.sops
  # ];

  options.system.security.sops = with types; {
    enable = mkBoolOpt true "Enable sops-nix";
  };

  config = mkIf cfg.enable {
    sops = {
      defaultSopsFile = ../../../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "/home/${config.user.name}/.config/sops/age/keys.txt";
    };
    system.persist.home.dirs = [
      ".config/sops"
    ];
    environment = {
      systemPackages = with pkgs; [
        (writeShellScriptBin "sops" ''
          EDITOR=${config.environment.variables.EDITOR} ${pkgs.sops}/bin/sops $@
        '')
        age
      ];
    };

    sops.secrets."system/password" = {neededForUsers = true;};
    sops.secrets."minio/access-key" = {};
    sops.secrets."minio/secret-key" = {};
  };
}
