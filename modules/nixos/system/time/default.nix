{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.time;
in {
  options.system.time = with types; {
    enable = mkBoolOpt false "Whether or not to configure timezone information.";
  };

  config = mkIf cfg.enable {time.timeZone = "America/Chicago";};
}
