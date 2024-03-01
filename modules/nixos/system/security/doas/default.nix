{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.security.doas;
in {
  options.system.security.doas = {
    enable = mkBoolOpt false "Enable doas";
    replaceSudo = mkBoolOpt true "replace sudo with doas";
    noPassword = mkBoolOpt false "Don't require password with doas";
  };

  config = mkIf cfg.enable {
    security.sudo.enable = mkIf cfg.replaceSudo false;

    environment.shellAliases = mkIf cfg.replaceSudo {sudo = "doas";};

    security.doas = {
      enable = true;
      extraRules = [
        {
          users = [config.user.name];
          noPass = cfg.noPassword;
          keepEnv = true;
        }
      ];
    };
  };
}
