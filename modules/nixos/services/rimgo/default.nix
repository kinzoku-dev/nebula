{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.rimgo;
in {
  options.rimgo = with types; {
    enable = mkBoolOpt false "Enable rimgo";
  };

  config = mkIf cfg.enable {
    services.rimgo = {
      enable = true;
      settings = {
        PORT = 4206;
        ADDRESS = "0.0.0.0";
      };
    };
  };
}
