{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-kinzoku.url = "github:kinzoku-dev/nixpkgs";

    jovian-nixos.url = "github:Jovian-Experiments/Jovian-NixOS";

    stylix.url = "github:danth/stylix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Theming and colors related
    nix-colors.url = "github:misterio77/nix-colors";
    prism.url = "github:IogaMaster/prism";

    talhelper.url = "github:budimanjojo/talhelper";

    snowfall-lib = {
      url = "github:snowfallorg/lib/dev";
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
      url = "github:hyprwm/Hyprland?ref=v0.36.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    # split-monitor-workspaces = {
    #   url = "github:Duckonaut/split-monitor-workspaces";
    #   inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    # };
    hyprsome = {
      url = "github:sopa0/hyprsome";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprlock = {
      url = "github:hyprwm/hyprlock";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hypridle = {
      url = "github:hyprwm/hypridle";
      inputs.nixpkgs.follows = "hyprland";
    };
    pyprland = {
      url = "github:hyprland-community/pyprland";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
    };

    shadower = {
      url = "github:n3oney/shadower";
    };
    wayfreeze = {
      url = "github:jappie3/wayfreeze";
    };

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun-nixos-options = {
      url = "github:n3oney/anyrun-nixos-options";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Deployments
    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.1.0";

    ags.url = "github:Aylur/ags";

    xremap-flake.url = "github:xremap/nix-flake";

    nur.url = "github:nix-community/NUR";
    disko = {
      url = "github:raidenovich/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plugin-move = {
      url = "github:fedepujol/move.nvim";
      flake = false;
    };
    plugin-neocord = {
      url = "github:IogaMaster/neocord";
      flake = false;
    };
    plugin-aerial = {
      url = "github:stevearc/aerial.nvim";
      flake = false;
    };
    plugin-silicon = {
      url = "github:michaelrommel/nvim-silicon";
      flake = false;
    };

    plugin-tmux-base16-statusline = {
      url = "github:jatap/tmux-base16-statusline";
      flake = false;
    };
    plugin-tmux-base16-tmux = {
      url = "github:tinted-theming/base16-tmux";
      flake = false;
    };
    plugin-nvim-ansible = {
      url = "github:mfussenegger/nvim-ansible";
      flake = false;
    };

    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:kinzoku-dev/impermanence";

    catppuccin-bat = {
      url = "github:catppuccin/bat";
      flake = false;
    };
    catppuccin-cava = {
      url = "github:catppuccin/cava";
      flake = false;
    };
    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
    vesktop.url = "github:NixOS/nixpkgs/5607766da72127e8daa6bc58edddf8e4b9506986";

    # dolphin-emu-nix.url = "github:matthewcroughan/dolphin-emu-nix";
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
        # neovim.overlays.x86_64-linux.neovim
        fenix.overlays.default
      ];
      systems = {
        hosts = {
          nova.modules = with inputs; [
            (import ./disks/default.nix {
              inherit lib;
              swap = true;
              device = "/dev/nvme0n1";
              impermanence = true;
            })
          ];
          deck.modules = with inputs; [
            (import ./disks/default.nix {
              inherit lib;
              swap = true;
              swapSize = "16";
              device = "/dev/nvme0n1";
              impermanence = true;
            })
          ];
        };

        modules.nixos = with inputs; [
          home-manager.nixosModules.home-manager
          nur.nixosModules.nur
          disko.nixosModules.disko
          arion.nixosModules.arion
          nixvim.nixosModules.nixvim
          impermanence.nixosModules.impermanence
        ];
      };
      templates = import ./templates {};
      deploy = lib.mkDeploy {inherit (inputs) self;};
      checks =
        builtins.mapAttrs (
          _system: deploy-lib: deploy-lib.deployChecks inputs.self.deploy
        )
        inputs.deploy-rs.lib;
    };
}
