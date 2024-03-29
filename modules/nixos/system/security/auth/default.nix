{
  options,
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.security.auth;
in {
  options.system.security.auth = with types; {
    enable = mkBoolOpt true "Enable auth";
  };

  config = mkIf cfg.enable {
    services.gnome.gnome-keyring.enable = true;
    security = {
      polkit.enable = true;
    };
    system.persist.home.dirs = [
      ".local/share/keyrings"
      ".pki"
    ];
  };
}
