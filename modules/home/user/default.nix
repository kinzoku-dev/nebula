{
  lib,
  config,
  options,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.home.user;

  home-directory =
    if cfg.name == null
    then null
    else "/home/${cfg.name}";
in {
  options.home.user = with types; {
    enable = mkBoolOpt false "Whether to configure the user account.";
    name = mkOpt (nullOr str) config.snowfallorg.user.name "The user account.";

    fullName = mkOpt str "Ayman Hamza" "The full name of the user.";
    email = mkOpt str "kinzokudev4869@gmail.com" "The email of the user.";

    homeDir = mkOpt (nullOr str) home-directory "The user's home directory.";
  };

  config = mkIf cfg.enable (mkMerge [
    {
      assertions = [
        {
          assertion = cfg.name != null;
          message = "home.user.name must be set";
        }
        {
          assertion = cfg.homeDir != null;
          message = "home.user.homeDir must be set";
        }
      ];

      home = {
        username = mkDefault cfg.name;
        homeDirectory = mkDefault cfg.homeDir;
      };
    }
  ]);
}
