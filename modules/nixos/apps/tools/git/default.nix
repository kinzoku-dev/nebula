{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.tools.git;
in {
  options.apps.tools.git = with types; {
    enable = mkBoolOpt false "Enable or disable git";
    gpgKey = mkOpt str "" "GPG key";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      git-remote-gcrypt

      gh

      lazygit
      commitizen
    ];

    home.configFile."git/config".text = import ./config.nix {
      inherit (cfg) gpgKey;
    };
    home.configFile."lazygit/config.yml".source = ./lazygitConfig.yml;
  };
}
