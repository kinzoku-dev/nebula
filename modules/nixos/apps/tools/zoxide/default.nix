{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.tools.zoxide;
in {
  options.apps.tools.zoxide = with types; {
    enable = mkBoolOpt false "Enable or disable zoxide";
  };

  config = mkIf cfg.enable {
    home.programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
