{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.nginx;
in {
  options.nginx = with types; {
    enable = mkBoolOpt false "enable nginx for server";
  };

  config = mkIf cfg.enable {
    services.nginx = {
      enable = true;
      user = "kinzoku";
    };
  };
}
