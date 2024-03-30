{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.user;
in {
  options.user = with types; {
    name = mkOpt str "kinzoku" "The name of the user's account";
    initialPassword = mkOpt str "password123_*()" "The initial password to use";
    extraGroups = mkOpt (listOf str) [] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs {} "Extra options passed to users.users.<name>";
  };

  config = {
    environment.sessionVariables.FLAKE = "/home/kinzoku/dev/nebula";

    users.users.kinzoku =
      {
        isNormalUser = true;
        inherit (cfg) name initialPassword;
        home = "/home/kinzoku";
        group = "users";

        extraGroups =
          [
            "wheel"
            "audio"
            "sound"
            "video"
            "networkmanager"
            "input"
            "tty"
          ]
          ++ cfg.extraGroups;
      }
      // cfg.extraOptions;
  };
}
