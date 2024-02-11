{
  config,
  pkgs,
  lib,
  options,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.thunderbird;
in {
  options.apps.thunderbird = with types; {
    enable = mkBoolOpt false "Enable thunderbird";
  };

  config = lib.mkIf cfg.enable {
    home.programs.thunderbird = {
      enable = true;
      profiles = {
        "kinzoku" = {
          isDefault = true;
        };
      };
    };
  };
}
