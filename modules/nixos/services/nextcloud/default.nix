{
  config,
  options,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.nextcloud;
in {
  options.nextcloud = with types; {
    enable = mkBoolOpt false "Enable nextcloud instance";
  };

  config = mkIf cfg.enable {
    # TODO: add nextcloud instance config
    services.nextcloud = {
      enable = true;
    };
  };
}
