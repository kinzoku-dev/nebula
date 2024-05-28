{
  config,
  options,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.clusterUtils;
in {
  options.apps.clusterUtils = with types; {
    enable = mkBoolOpt false "Enable utility apps for cluster management";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (ansible.overrideAttrs (old: rec {
        pname = "ansible_core";
        version = "2.17.0";

        src = fetchPypi {
          inherit pname version;
          hash = "sha256-vRbjDsrEBdrFlN4+GxtNnMb6Gp96Aaao1MRxsgZgcW0=";
        };
      }))
      python3

      fluxcd

      kubectl

      terraform
      cf-terraforming

      go-task
      helmfile
      yq
      jq
      kubeconform
      kustomize
      moreutils
      stern

      talosctl
      inputs.talhelper.packages.x86_64-linux.default

      cloudflared

      lens

      minikube
      docker-machine-kvm2
    ];

    environment.shellAliases = {
      mk = "minikube";
    };
  };
}
