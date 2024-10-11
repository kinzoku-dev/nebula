{
  inputs,
  outputs,
  hostname,
  userinfo,
  ...
}: {
  imports = [
    ./core
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit
        inputs
        outputs
        userinfo
        hostname
        ;
    };
    useGlobalPkgs = false;
    useUserPackages = true;
    users = {
      ${userinfo.name} = import ./home-manager;
    };
    backupFileExtension = "backup";
  };
}
