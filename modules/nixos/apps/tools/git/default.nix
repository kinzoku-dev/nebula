{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.tools.git;
in {
  options.apps.tools.git = with types; {
    enable = mkBoolOpt false "Enable or disable git";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      git
      git-remote-gcrypt

      gh

      lazygit
      commitizen
    ];

    environment.shellAliases = {
    };

    home.configFile."git/config".source = ./config;
    home.configFile."lazygit/config.yml".source = ./lazygitConfig.yml;
  };
}
