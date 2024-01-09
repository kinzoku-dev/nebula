{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.rofi;
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) colors;
in {
  options.apps.rofi = with types; {
    enable = mkBoolOpt false "Enable rofi";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rofi-wayland
    ];
    home.configFile."rofi/colors/colorscheme.rasi".text = ''
      * {
          background: #${colors.base01};
          background-alt: #${colors.base01};
          foreground: #${colors.base05};
          selected: #${colors.base07};
          active: #${colors.base03};
          urgent: #${colors.base08};
      }
    '';
    home.configFile."rofi/launchers/type-1/launcher.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        dir="$HOME/.config/rofi/launchers/type-1"
        theme='style-1'

        rofi \
          -show drun \
          -theme ''${dir}/''${theme}.rasi
      '';
    };
    home.configFile."rofi/launchers/type-1/shared/fonts.rasi".text = ''
      * {
          font: "JetBrains Mono Nerd Font 10";
      }
    '';
    home.configFile."rofi/launchers/type-1/shared/colors.rasi".text = ''
      @import "~/.config/rofi/colors/colorscheme.rasi"
    '';
    home.configFile."rofi/launchers/type-1/style-1.rasi".text = ''
      configuration {
          modi: "drun,run,filebrowser";
          show-icons: true;
          display-drun: "󰀻 Apps";
          display-run: " Run";
          display-filebrowser: " Files";
          display-window: " Windows";
          drun-display-format: "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
          window-format: "{w} 󰧟 {c} 󰧟 {t}";
      }

      @import "shared/colors.rasi"
      @import "shared/fonts.rasi"

      * {
          border-colour:               var(selected);
          handle-colour:               var(selected);
          background-colour:           var(background);
          foreground-colour:           var(foreground);
          alternate-background:        var(background-alt);
          normal-background:           var(background);
          normal-foreground:           var(foreground);
          urgent-background:           var(urgent);
          urgent-foreground:           var(background);
          active-background:           var(active);
          active-foreground:           var(background);
          selected-normal-background:  var(selected);
          selected-normal-foreground:  var(background);
          selected-urgent-background:  var(active);
          selected-urgent-foreground:  var(background);
          selected-active-background:  var(urgent);
          selected-active-foreground:  var(background);
          alternate-normal-background: var(background);
          alternate-normal-foreground: var(foreground);
          alternate-urgent-background: var(urgent);
          alternate-urgent-foreground: var(background);
          alternate-active-background: var(active);
          alternate-active-foreground: var(background);
      }

      window {
          transparency: "real";
      }
    '';
  };
}
