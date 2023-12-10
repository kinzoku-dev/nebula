{
  options,
  config,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; {
  imports = with inputs; [
    nix-colors.homeManagerModules.default
    prism.homeModules.prism
    # nebuvim.homeManagerModules.default
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
    packages = mkOpt (listOf str) [] "Packages to be installed with home-manager.";
    mimeApps = mkOpt attrs {} "Mime app settings.";
    pointerCursor = mkOpt attrs {} "Cursor settings";
  };

  config = {
    home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.home.configFile;
      xdg.mimeApps = mkAliasDefinitions options.home.mimeApps;
      programs = mkAliasDefinitions options.home.programs;
      home.homeDirectory = "/home/${config.user.name}";
      home.pointerCursor = mkIf config.desktop.gtk.enable (mkAliasDefinitions options.home.pointerCursor);
    };

    home.packages = mkAliasDefinitions options.home.packages;

    home-manager = {
      useUserPackages = true;
      backupFileExtension = "backup";

      users.${config.user.name} =
        mkAliasDefinitions options.home.extraOptions;
    };
  };
}
