{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Theming and colors related
    nix-colors.url = "github:misterio77/nix-colors";
    prism.url = "github:IogaMaster/prism";

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim = {
      url = "github:kinzoku-dev/neovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.1.0";

    ags.url = "github:Aylur/ags";
  };

  outputs = inputs: let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;

      snowfall = {
        meta = {
          name = "nebula-flake";
          title = "Nebula Flake";
        };

        namespace = "nebula";
      };
    };
  in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "electron-24.8.6"
        ];
      };

      overlays = with inputs; [
        neovim.overlays.x86_64-linux.neovim
      ];

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
      ];
      templates = import ./templates {};
    };
}
