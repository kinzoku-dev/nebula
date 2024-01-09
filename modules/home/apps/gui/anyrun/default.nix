{
  config,
  options,
  osConfig,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.home.apps.gui.anyrun;
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.home.desktop.colorscheme}) colors;
in {
  options.home.apps.gui.anyrun = with types; {
    enable = mkBoolOpt false "Enable anyrun";
  };

  imports = [inputs.anyrun.homeManagerModules.default];
  config = mkIf cfg.enable {
    programs.anyrun = {
      enable = true;
      config = {
        plugins = with inputs.anyrun.packages.${pkgs.system}; [
          applications
          rink
          shell
          symbols
          translate
        ];

        width.fraction = 0.3;
        y.absolute = 15;
        hidePluginInfo = true;
        closeOnClick = true;
      };
      extraCss = ''
        * {
          transition: 200ms ease;
          font-family: JetBrainsMono Nerd Font;
          font-size: 1.3rem;
        }

        #window,
        #match,
        #entry,
        #plugin,
        #main {
          background: transparent;
        }

        #match:selected {
          background: rgba(203, 166, 247, 0.7);
        }

        #match {
          padding: 3px;
          border-radius: 16px;
        }

        #entry, #plugin:hover {
          border-radius: 16px;
        }

        box#main {
          background: rgba(30, 30, 46, 0.7);
          border: 1px solid;
          border-color: linear-gradient(45deg, rgb(${colors.base0E}), rgb(${colors.base0E}), rgb(${colors.base07}), rgb(${colors.base0D}), 100%);
          border-radius: 24px;
          padding: 8px;
        }
      '';
      extraConfigFiles."applications.ron".text = ''
        Config(
          desktop_actions: false,
          max_entries: 5,
          terminal: Some("kitty"),
        )
      '';
    };
  };
}
