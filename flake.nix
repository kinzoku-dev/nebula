{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

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
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Deployments
    arion.url = "github:hercules-ci/arion";
    arion.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.1.0";

    ags.url = "github:Aylur/ags";

    xremap-flake.url = "github:xremap/nix-flake";

    nur.url = "github:nix-community/NUR";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";

    # nebuvim = {
    #   url = "github:kinzoku-dev/nebuvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    schizofox = {
      url = "github:schizofox/schizofox";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
          "vscode-1.84.2"
        ];
      };

      overlays = with inputs; [
        neovim.overlays.x86_64-linux.neovim
      ];

      systems.hosts.eclipse.modules = with inputs; [
        (import ./disks/default.nix {inherit lib;})
      ];

      systems.modules.nixos = with inputs; [
        home-manager.nixosModules.home-manager
        nur.nixosModules.nur
        disko.nixosModules.disko
        arion.nixosModules.arion
      ];
      templates = import ./templates {};
      deploy = lib.mkDeploy {inherit (inputs) self;};
      checks =
        builtins.mapAttrs
        (_system: deploy-lib:
          deploy-lib.deployChecks inputs.self.deploy)
        inputs.deploy-rs.lib;
    };
}
