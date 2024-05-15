{
  config,
  pkgs,
  lib,
  options,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.onepassword;
in {
  options.apps.onepassword = with types; {
    enable = mkBoolOpt false "Enable 1password";
  };

  config = mkIf cfg.enable {
    programs = {
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = ["kinzoku"];
      };
    };
  };
}
