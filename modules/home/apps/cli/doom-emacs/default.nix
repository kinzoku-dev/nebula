{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.home.apps.cli.doom-emacs;
in {
  imports = [
    inputs.nix-doom-emacs.hmModule
  ];
  options.home.apps.cli.doom-emacs = with types; {
    enable = mkBoolOpt false "Enable or disable doom emacs";
  };

  config = mkIf cfg.enable {
    programs.doom-emacs = {
      enable = true;
      doomPrivateDir = ./doom.d;
    };
  };
}
