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
  # defaultIconFileName = "profile.png";
  # defaultIcon = pkgs.stdenvNoCC.mkDerivation {
  #   name = "default-icon";
  #   src = ./. + "/${defaultIconFileName}";
  #
  #   dontunpack = true;
  #
  #   installPhase = ''
  #     cp $src $out
  #   '';
  #
  #   passthru = {fileName = defaultIconFileName;};
  # };
  #
  # propagatedIcon =
  #   pkgs.runCommandNoCC "propagated-icon"
  #   {passthru = {inherit (cfg.icon) fileName;};}
  #   ''
  #     local target="$out/share/icons/user/${cfg.name}"
  #     mkdir -p "$target"
  #
  #     cp ${cfg.icon} "$target/${cfg.icon.fileName}"
  #   '';
in {
  options.user = with types; {
    name = mkOpt str "kinzoku" "The name of the user's account";
    initialPassword =
      mkOpt str "password"
      "The initial password to use when the user is first created.";
    # icon =
    #   mkOpt (nullOr package) defaultIcon
    #   "The profile picture to use for the user.";
    extraGroups = mkOpt (listOf str) [] "Groups for the user to be assigned.";
    extraOptions =
      mkOpt attrs {}
      "Extra options passed to <option>users.users.<name></option>.";
  };

  config = {
    home = {
      file = {
        "Documents/.keep".text = "";
        "Downloads/.keep".text = "";
        "Music/.keep".text = "";
        "Images/.keep".text = "";
        "Dev/.keep".text = "";
        # ".face".source = cfg.icon;
        # "Images/${
        #   cfg.icon.fileName or (builtins.baseNameOf cfg.icon)
        # }".source =
        #   cfg.icon;
      };
    };
    environment = {
      systemPackages = with pkgs; [
        # propagatedIcon
      ];

      sessionVariables.FLAKE = "/home/${cfg.name}/Dev/nebula";
      persist.home.directories = [
        "Documents"
        "Music"
        "Images"
        "Dev"
      ];
    };

    users.users.${cfg.name} =
      {
        isNormalUser = true;
        inherit (cfg) name;
        home = "/home/${cfg.name}";
        group = "users";

        hashedPasswordFile = lib.mkForce config.sops.secrets."system/password".path;

        extraGroups =
          [
            "wheel"
            "audio"
            "sound"
            "video"
            "networkmanager"
            "input"
            "tty"
            "docker"
          ]
          ++ cfg.extraGroups;
      }
      // cfg.extraOptions;

    users.users.root.hashedPasswordFile = lib.mkForce config.sops.secrets."system/password".path;

    users.mutableUsers = false;
  };
}
