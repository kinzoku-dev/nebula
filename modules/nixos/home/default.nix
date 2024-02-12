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
    schizofox.homeManagerModules.default
    spicetify-nix.homeManagerModule
    # stylix.homeManagerModules.stylix
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
    services = mkOpt attrs {} "service settings";
    activation = mkOpt attrs {} "activation settings";
    xdgDesktopEntries = mkOpt attrs {} "xdg settings";
  };

  config = {
    programs.fuse.userAllowOther = true;
    home.extraOptions = {
      home.stateVersion = config.system.stateVersion;
      home.file = mkAliasDefinitions options.home.file;
      xdg.enable = true;
      xdg.configFile = mkAliasDefinitions options.home.configFile;
      xdg.mimeApps = mkAliasDefinitions options.home.mimeApps;
      xdg.desktopEntries = mkAliasDefinitions options.home.xdgDesktopEntries;
      programs = mkAliasDefinitions options.home.programs;
      services = mkAliasDefinitions options.home.services;
      home.homeDirectory = "/home/${config.user.name}";
      home.pointerCursor = mkIf config.desktop.gtk.enable (mkAliasDefinitions options.home.pointerCursor);
      home.activation = mkAliasDefinitions options.home.activation;
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
