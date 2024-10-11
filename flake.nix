{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko.url = "github:ardishko/disko";
  };

  outputs = {
    nixpkgs,
    disko,
    home-manager,
    ...
  } @ inputs: let
    lib = nixpkgs.lib // home-manager.lib;
    userinfo = {
      name = "kinzoku";
      fullname = "Ayman";
      email = "kinzoku@the-nebula.xyz";
    };
  in {
    nixosConfigurations.nova = lib.nixosSystem (let
      hostname = "NOVA";
      isServer = false;
    in {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs hostname userinfo isServer;
      };
      modules = [
        ./hosts/${lib.toLower hostname}
        ./modules
        ./secrets
        disko.nixosModules.disko
        (import ./disko.nix {
          device = "/dev/nvme0n1";
          inherit hostname;
        })
      ];
    });
    nixosConfigurations.satellite = lib.nixosSystem (let
      hostname = "SATELLITE";
      isServer = false;
    in {
      system = "x86_64-linux";
      specialArgs = {inherit inputs hostname userinfo isServer;};
      modules = [
        ./hosts/${lib.toLower hostname}
        ./modules
        ./secrets
        disko.nixosModules.disko
        (import ./disko.nix {
          device = "/dev/nvme0n1";
          inherit hostname;
        })
      ];
    });
  };
}
