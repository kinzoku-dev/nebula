{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.cron;
in {
  options.system.cron = with types; {
    enable = mkBoolOpt false "Enable cron";
  };

  config = mkIf cfg.enable {
    services.cron = {
      enable = true;
    };
  };
}
