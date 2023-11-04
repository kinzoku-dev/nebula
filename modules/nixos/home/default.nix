{
  options,
  config,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom; {
  imports = with inputs; [
    home-manager.nixosModules.home-manager
    nix-colors.homeManagerModules.default
    prism.homeModules.prism
  ];

  options.home = with types; {
    file =
      mkOpt attrs {}
      "A set of files to be managed by home-manager's home.file";
    configFile =
      mkOpt attrs {}
      "A set of files to be managed by home-manager's xdg.configFile";
    programs = mkOpt attrs {} "Programs to be managed by home-manager.";
    extraOptions = mkOpt attrs {} "Options to pass directly to home-manager.";
  };

  config = {
    home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.home.configFile;
      programs = mkAliasDefinitions options.home.programs;
    };

    home-manager = {
      useUserPackages = true;

      users.${config.user.name} =
        mkAliasDefinitions options.home.extraOptions;
    };
  };
}
