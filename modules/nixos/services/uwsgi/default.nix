{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.uwsgi;
in {
  options.uwsgi = with types; {
    enable = mkBoolOpt false "Enable uwsgi";
  };

  config = mkIf cfg.enable {
    services.uwsgi = {
      enable = true;
      plugins = ["python3"];
    };
  };
}
