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
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) palette;
  colors = palette;
in {
  options.apps.rofi = with types; {
    enable = mkBoolOpt false "Enable rofi";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      rofi-wayland
    ];
    home.programs.rofi = {
      enable = true;
      plugins = with pkgs; [
        rofi-calc
        rofi-emoji
      ];
    };
    home.configFile."rofi/colors/colorscheme.rasi".text = ''
      * {
          background: #${colors.base01}99;
          background-alt: #${colors.base01}99;
          foreground: #${colors.base05};
          selected: #${colors.base07};
          active: #${colors.base03};
          urgent: #${colors.base08};
      }
    '';
    home.configFile."rofi/launchers/type-1/shared/fonts.rasi".text = ''
      * {
          font: "JetBrains Mono Nerd Font 12";
      }
    '';
    home.configFile."rofi/launchers/type-1/shared/colors.rasi".text = ''
      @import "~/.config/rofi/colors/colorscheme.rasi"
    '';
    home.configFile."rofi/launchers/calculator/shared/fonts.rasi".text = ''
      * {
          font: "JetBrains Mono Nerd Font 12";
      }
    '';
    home.configFile."rofi/launchers/calculator/shared/colors.rasi".text = ''
      @import "~/.config/rofi/colors/colorscheme.rasi"
    '';
    home.configFile."rofi/launchers/wallpaper-selector/shared/fonts.rasi".text = ''
      * {
          font: "JetBrains Mono Nerd Font 12";
      }
    '';
    home.configFile."rofi/launchers/wallpaper-selector/shared/colors.rasi".text = ''
      @import "~/.config/rofi/colors/colorscheme.rasi"
    '';
    home.configFile."rofi/launchers/pdf-launcher/shared/fonts.rasi".text = ''
      * {
          font: "JetBrains Mono Nerd Font 12";
      }
    '';
    home.configFile."rofi/launchers/pdf-launcher/shared/colors.rasi".text = ''
      @import "~/.config/rofi/colors/colorscheme.rasi"
    '';
    home.configFile."rofi/clipboard/shared/fonts.rasi".text = ''
      * {
          font: "JetBrains Mono Nerd Font 12";
      }
    '';
    home.configFile."rofi/clipboard/shared/colors.rasi".text = ''
      @import "~/.config/rofi/colors/colorscheme.rasi"
    '';
    home.configFile."rofi/wifi-menu/shared/fonts.rasi".text = ''
      * {
          font: "JetBrains Mono Nerd Font 12";
      }
    '';
    home.configFile."rofi/wifi-menu/shared/colors.rasi".text = ''
      @import "~/.config/rofi/colors/colorscheme.rasi"
    '';
    home.configFile."rofi/emoji/shared/fonts.rasi".text = ''
      * {
          font: "JetBrains Mono Nerd Font 12";
      }
    '';
    home.configFile."rofi/emoji/shared/colors.rasi".text = ''
      @import "~/.config/rofi/colors/colorscheme.rasi"
    '';
    home.configFile."rofi/powermenu/shared/fonts.rasi".text = ''
      * {
          font: "JetBrains Mono Nerd Font 12";
      }
    '';
    home.configFile."rofi/powermenu/shared/colors.rasi".text = ''
      @import "~/.config/rofi/colors/colorscheme.rasi"
    '';
    home.configFile."rofi/launchers/type-1/style-1.rasi".text = ''
                        configuration {
                            modi: "drun,run,filebrowser,window";
                            show-icons: true;
                            display-drun: "󰀻";
                            display-run: "";
                            display-filebrowser: "󰉖";
                            display-window: "";
                            drun-display-format: "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
                            window-format: "{w} 󰧟 {c} 󰧟 {t}";
                            display-clipboard: "󰅌";
                            display-dmenu: "󰍜";
                            dmenu-display-format: "󰍜";
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
                          width: 800px;
                          border-radius: 10px;
                          border: 3px solid;
                          border-color: @border-colour;
                          padding: 0px;
                          location: center;
                          anchor: center;
                          fullscreen: false;
                          x-offset: 0px;
                          y-offest: 0px;
                          enabled: true;
                          margin: 0px;
                          cursor: "default";
                          background-color: @background-colour;
                        }
                        mainbox {
                            enabled: true;
                            spacing: 10px;
                            margin: 0px;
                            padding: 40px;
                            border: 0px solid;
                            border-radius: 0px 0px 0px 0px;
                            border-color: @border-colour;
                            background-color: transparent;
                            children: [ "inputbar", "message", "listview", "mode-switcher" ];
                        }
                        inputbar {
                            enabled: true;
                            spacing: 10px;
                            margin: 0px;
                            padding: 0px;
                            border: 0px solid;
                            border-color: @border-colour;
                            background-color: transparent;
                            text-color: @foreground-colour;
                            children: [ "prompt", "textbox-prompt-colon", "entry" ];
                        }

                        prompt {
                            enabled: true;
                            background-color: inherit;
                            text-color: inherit;
                        }
                        textbox-prompt-colon {
                          enabled: true;
                          expand: false;
                          str: "";
                          background-color: inherit;
                          text-color: inherit;
                        }
                        entry {
                            enabled: true;
                            background-color: inherit;
                            text-color: inherit;
                            cursor: text;
                            placeholder: "Search...";
                            placeholder-color: inherit;
                        }
                  num-filtered-rows {
                      enabled:                     true;
                      expand:                      false;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  textbox-num-sep {
                      enabled:                     true;
                      expand:                      false;
                      str:                         "/";
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  num-rows {
                      enabled:                     true;
                      expand:                      false;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  case-indicator {
                      enabled:                     true;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
            listview {
                enabled:                     true;
                columns:                     2;
                lines:                       10;
                cycle:                       true;
                dynamic:                     true;
                scrollbar:                   true;
                layout:                      vertical;
                reverse:                     false;
                fixed-height:                true;
                fixed-columns:               true;

                spacing:                     5px;
                margin:                      0px;
                padding:                     0px;
                border:                      0px solid;
                border-radius:               0px;
                border-color:                @border-colour;
                background-color:            transparent;
                text-color:                  @foreground-colour;
                cursor:                      "default";
            }
            scrollbar {
              handle-width:                10px ;
              handle-color:                @handle-colour;
              border-radius:               10px;
              background-color:            @alternate-background;
            }
            element {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          cursor:                      pointer;
      }
      element normal.normal {
          background-color:            var(normal-background);
          text-color:                  var(normal-foreground);
      }
      element normal.urgent {
          background-color:            var(urgent-background);
          text-color:                  var(urgent-foreground);
      }
      element normal.active {
          background-color:            var(active-background);
          text-color:                  var(active-foreground);
      }
      element selected.normal {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }
      element selected.urgent {
          background-color:            var(selected-urgent-background);
          text-color:                  var(selected-urgent-foreground);
      }
      element selected.active {
          background-color:            var(selected-active-background);
          text-color:                  var(selected-active-foreground);
      }
      element alternate.normal {
          background-color:            var(alternate-normal-background);
          text-color:                  var(alternate-normal-foreground);
      }
      element alternate.urgent {
          background-color:            var(alternate-urgent-background);
          text-color:                  var(alternate-urgent-foreground);
      }
      element alternate.active {
          background-color:            var(alternate-active-background);
          text-color:                  var(alternate-active-foreground);
      }
      element-icon {
          background-color:            transparent;
          text-color:                  inherit;
          size:                        24px;
          cursor:                      inherit;
      }
      element-text {
          background-color:            transparent;
          text-color:                  inherit;
          highlight:                   inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.0;
      }

      /*****----- Mode Switcher -----*****/
      mode-switcher{
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      button {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  inherit;
          cursor:                      pointer;
      }
      button selected {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }

      /*****----- Message -----*****/
      message {
          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px 0px 0px 0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      textbox {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  @foreground-colour;
          vertical-align:              0.5;
          horizontal-align:            0.0;
          highlight:                   none;
          placeholder-color:           @foreground-colour;
          blink:                       true;
          markup:                      true;
      }
      error-message {
          padding:                     10px;
          border:                      2px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @background-colour;
          text-color:                  @foreground-colour;
      }
    '';
    home.configFile."rofi/wifi-menu/style-1.rasi".text = ''
                        configuration {
                            modi: "drun,run,filebrowser,window";
                            show-icons: true;
                            display-drun: "󰀻";
                            display-run: "";
                            display-filebrowser: "󰉖";
                            display-window: "";
                            drun-display-format: "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
                            window-format: "{w} 󰧟 {c} 󰧟 {t}";
                            display-clipboard: "󰅌";
                            display-dmenu: "󰍜";
                            display-wifi: "󰖩";
                            dmenu-display-format: "󰍜";
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
                          width: 800px;
                          border-radius: 10px;
                          border: 3px solid;
                          border-color: @border-colour;
                          padding: 0px;
                          location: center;
                          anchor: center;
                          fullscreen: false;
                          x-offset: 0px;
                          y-offest: 0px;
                          enabled: true;
                          margin: 0px;
                          cursor: "default";
                          background-color: @background-colour;
                        }
                        mainbox {
                            enabled: true;
                            spacing: 10px;
                            margin: 0px;
                            padding: 40px;
                            border: 0px solid;
                            border-radius: 0px 0px 0px 0px;
                            border-color: @border-colour;
                            background-color: transparent;
                            children: [ "inputbar", "message", "listview", "mode-switcher" ];
                        }
                        inputbar {
                            enabled: true;
                            spacing: 10px;
                            margin: 0px;
                            padding: 0px;
                            border: 0px solid;
                            border-color: @border-colour;
                            background-color: transparent;
                            text-color: @foreground-colour;
                            children: [ "prompt", "textbox-prompt-colon", "entry" ];
                        }

                        prompt {
                            enabled: true;
                            background-color: inherit;
                            text-color: inherit;
                        }
                        textbox-prompt-colon {
                          enabled: true;
                          expand: false;
                          str: "";
                          background-color: inherit;
                          text-color: inherit;
                        }
                        entry {
                            enabled: true;
                            background-color: inherit;
                            text-color: inherit;
                            cursor: text;
                            placeholder: "Connect to Network...";
                            placeholder-color: inherit;
                        }
                  num-filtered-rows {
                      enabled:                     true;
                      expand:                      false;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  textbox-num-sep {
                      enabled:                     true;
                      expand:                      false;
                      str:                         "/";
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  num-rows {
                      enabled:                     true;
                      expand:                      false;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  case-indicator {
                      enabled:                     true;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
            listview {
                enabled:                     true;
                columns:                     2;
                lines:                       10;
                cycle:                       true;
                dynamic:                     true;
                scrollbar:                   true;
                layout:                      vertical;
                reverse:                     false;
                fixed-height:                true;
                fixed-columns:               true;

                spacing:                     5px;
                margin:                      0px;
                padding:                     0px;
                border:                      0px solid;
                border-radius:               0px;
                border-color:                @border-colour;
                background-color:            transparent;
                text-color:                  @foreground-colour;
                cursor:                      "default";
            }
            scrollbar {
              handle-width:                10px ;
              handle-color:                @handle-colour;
              border-radius:               10px;
              background-color:            @alternate-background;
            }
            element {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          cursor:                      pointer;
      }
      element normal.normal {
          background-color:            var(normal-background);
          text-color:                  var(normal-foreground);
      }
      element normal.urgent {
          background-color:            var(urgent-background);
          text-color:                  var(urgent-foreground);
      }
      element normal.active {
          background-color:            var(active-background);
          text-color:                  var(active-foreground);
      }
      element selected.normal {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }
      element selected.urgent {
          background-color:            var(selected-urgent-background);
          text-color:                  var(selected-urgent-foreground);
      }
      element selected.active {
          background-color:            var(selected-active-background);
          text-color:                  var(selected-active-foreground);
      }
      element alternate.normal {
          background-color:            var(alternate-normal-background);
          text-color:                  var(alternate-normal-foreground);
      }
      element alternate.urgent {
          background-color:            var(alternate-urgent-background);
          text-color:                  var(alternate-urgent-foreground);
      }
      element alternate.active {
          background-color:            var(alternate-active-background);
          text-color:                  var(alternate-active-foreground);
      }
      element-icon {
          background-color:            transparent;
          text-color:                  inherit;
          size:                        24px;
          cursor:                      inherit;
      }
      element-text {
          background-color:            transparent;
          text-color:                  inherit;
          highlight:                   inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.0;
      }

      /*****----- Mode Switcher -----*****/
      mode-switcher{
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      button {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  inherit;
          cursor:                      pointer;
      }
      button selected {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }

      /*****----- Message -----*****/
      message {
          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px 0px 0px 0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      textbox {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  @foreground-colour;
          vertical-align:              0.5;
          horizontal-align:            0.0;
          highlight:                   none;
          placeholder-color:           @foreground-colour;
          blink:                       true;
          markup:                      true;
      }
      error-message {
          padding:                     10px;
          border:                      2px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @background-colour;
          text-color:                  @foreground-colour;
      }
    '';
    home.configFile."rofi/wifi-menu/wifi-password.rasi".text = ''
                        configuration {
                            modi: "drun,run,filebrowser,window";
                            show-icons: true;
                            display-drun: "󰀻";
                            display-run: "";
                            display-filebrowser: "󰉖";
                            display-window: "";
                            drun-display-format: "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
                            window-format: "{w} 󰧟 {c} 󰧟 {t}";
                            display-clipboard: "󰅌";
                            display-dmenu: "󰍜";
                            display-wifi: "󰖩";
                            dmenu-display-format: "󰍜";
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
                          width: 800px;
                          border-radius: 10px;
                          border: 3px solid;
                          border-color: @border-colour;
                          padding: 0px;
                          location: center;
                          anchor: center;
                          fullscreen: false;
                          x-offset: 0px;
                          y-offest: 0px;
                          enabled: true;
                          margin: 0px;
                          cursor: "default";
                          background-color: @background-colour;
                        }
                        mainbox {
                            enabled: true;
                            spacing: 10px;
                            margin: 0px;
                            padding: 40px;
                            border: 0px solid;
                            border-radius: 0px 0px 0px 0px;
                            border-color: @border-colour;
                            background-color: transparent;
                            children: [ "inputbar", "message", "listview", "mode-switcher" ];
                        }
                        inputbar {
                            enabled: true;
                            spacing: 10px;
                            margin: 0px;
                            padding: 0px;
                            border: 0px solid;
                            border-color: @border-colour;
                            background-color: transparent;
                            text-color: @foreground-colour;
                            children: [ "prompt", "textbox-prompt-colon", "entry" ];
                        }

                        prompt {
                            enabled: true;
                            background-color: inherit;
                            text-color: inherit;
                        }
                        textbox-prompt-colon {
                          enabled: true;
                          expand: false;
                          str: "";
                          background-color: inherit;
                          text-color: inherit;
                        }
                        entry {
                            enabled: true;
                            background-color: inherit;
                            text-color: inherit;
                            cursor: text;
                            placeholder: "Enter Passphrase...";
                            placeholder-color: inherit;
                        }
                  num-filtered-rows {
                      enabled:                     true;
                      expand:                      false;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  textbox-num-sep {
                      enabled:                     true;
                      expand:                      false;
                      str:                         "/";
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  num-rows {
                      enabled:                     true;
                      expand:                      false;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  case-indicator {
                      enabled:                     true;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
            listview {
                enabled:                     true;
                columns:                     2;
                lines:                       10;
                cycle:                       true;
                dynamic:                     true;
                scrollbar:                   true;
                layout:                      vertical;
                reverse:                     false;
                fixed-height:                true;
                fixed-columns:               true;

                spacing:                     5px;
                margin:                      0px;
                padding:                     0px;
                border:                      0px solid;
                border-radius:               0px;
                border-color:                @border-colour;
                background-color:            transparent;
                text-color:                  @foreground-colour;
                cursor:                      "default";
            }
            scrollbar {
              handle-width:                10px ;
              handle-color:                @handle-colour;
              border-radius:               10px;
              background-color:            @alternate-background;
            }
            element {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          cursor:                      pointer;
      }
      element normal.normal {
          background-color:            var(normal-background);
          text-color:                  var(normal-foreground);
      }
      element normal.urgent {
          background-color:            var(urgent-background);
          text-color:                  var(urgent-foreground);
      }
      element normal.active {
          background-color:            var(active-background);
          text-color:                  var(active-foreground);
      }
      element selected.normal {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }
      element selected.urgent {
          background-color:            var(selected-urgent-background);
          text-color:                  var(selected-urgent-foreground);
      }
      element selected.active {
          background-color:            var(selected-active-background);
          text-color:                  var(selected-active-foreground);
      }
      element alternate.normal {
          background-color:            var(alternate-normal-background);
          text-color:                  var(alternate-normal-foreground);
      }
      element alternate.urgent {
          background-color:            var(alternate-urgent-background);
          text-color:                  var(alternate-urgent-foreground);
      }
      element alternate.active {
          background-color:            var(alternate-active-background);
          text-color:                  var(alternate-active-foreground);
      }
      element-icon {
          background-color:            transparent;
          text-color:                  inherit;
          size:                        24px;
          cursor:                      inherit;
      }
      element-text {
          background-color:            transparent;
          text-color:                  inherit;
          highlight:                   inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.0;
      }

      /*****----- Mode Switcher -----*****/
      mode-switcher{
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      button {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  inherit;
          cursor:                      pointer;
      }
      button selected {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }

      /*****----- Message -----*****/
      message {
          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px 0px 0px 0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      textbox {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  @foreground-colour;
          vertical-align:              0.5;
          horizontal-align:            0.0;
          highlight:                   none;
          placeholder-color:           @foreground-colour;
          blink:                       true;
          markup:                      true;
      }
      error-message {
          padding:                     10px;
          border:                      2px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @background-colour;
          text-color:                  @foreground-colour;
      }
    '';
    home.configFile."rofi/launchers/wallpaper-selector/style-1.rasi".text = ''
                        configuration {
                            modi: "drun,run,filebrowser,window";
                            show-icons: true;
                            display-drun: "󰀻";
                            display-run: "";
                            display-filebrowser: "󰉖";
                            display-window: "";
                            display-wallpaper: "󰥶";
                            drun-display-format: "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
                            window-format: "{w} 󰧟 {c} 󰧟 {t}";
                            display-clipboard: "󰅌";
                            display-dmenu: "󰍜";
                            dmenu-display-format: "󰍜";
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
                          width: 800px;
                          border-radius: 10px;
                          border: 3px solid;
                          border-color: @border-colour;
                          padding: 0px;
                          location: center;
                          anchor: center;
                          fullscreen: false;
                          x-offset: 0px;
                          y-offest: 0px;
                          enabled: true;
                          margin: 0px;
                          cursor: "default";
                          background-color: @background-colour;
                        }
                        mainbox {
                            enabled: true;
                            spacing: 10px;
                            margin: 0px;
                            padding: 40px;
                            border: 0px solid;
                            border-radius: 0px 0px 0px 0px;
                            border-color: @border-colour;
                            background-color: transparent;
                            children: [ "inputbar", "message", "listview", "mode-switcher" ];
                        }
                        inputbar {
                            enabled: true;
                            spacing: 10px;
                            margin: 0px;
                            padding: 0px;
                            border: 0px solid;
                            border-color: @border-colour;
                            background-color: transparent;
                            text-color: @foreground-colour;
                            children: [ "prompt", "textbox-prompt-colon", "entry" ];
                        }

                        prompt {
                            enabled: true;
                            background-color: inherit;
                            text-color: inherit;
                        }
                        textbox-prompt-colon {
                          enabled: true;
                          expand: false;
                          str: "";
                          background-color: inherit;
                          text-color: inherit;
                        }
                        entry {
                            enabled: true;
                            background-color: inherit;
                            text-color: inherit;
                            cursor: text;
                            placeholder: "Select Wallpaper...";
                            placeholder-color: inherit;
                        }
                  num-filtered-rows {
                      enabled:                     true;
                      expand:                      false;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  textbox-num-sep {
                      enabled:                     true;
                      expand:                      false;
                      str:                         "/";
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  num-rows {
                      enabled:                     true;
                      expand:                      false;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  case-indicator {
                      enabled:                     true;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
            listview {
                enabled:                     true;
                columns:                     2;
                lines:                       10;
                cycle:                       true;
                dynamic:                     true;
                scrollbar:                   true;
                layout:                      vertical;
                reverse:                     false;
                fixed-height:                true;
                fixed-columns:               true;

                spacing:                     5px;
                margin:                      0px;
                padding:                     0px;
                border:                      0px solid;
                border-radius:               0px;
                border-color:                @border-colour;
                background-color:            transparent;
                text-color:                  @foreground-colour;
                cursor:                      "default";
            }
            scrollbar {
              handle-width:                10px ;
              handle-color:                @handle-colour;
              border-radius:               10px;
              background-color:            @alternate-background;
            }
            element {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          cursor:                      pointer;
      }
      element normal.normal {
          background-color:            var(normal-background);
          text-color:                  var(normal-foreground);
      }
      element normal.urgent {
          background-color:            var(urgent-background);
          text-color:                  var(urgent-foreground);
      }
      element normal.active {
          background-color:            var(active-background);
          text-color:                  var(active-foreground);
      }
      element selected.normal {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }
      element selected.urgent {
          background-color:            var(selected-urgent-background);
          text-color:                  var(selected-urgent-foreground);
      }
      element selected.active {
          background-color:            var(selected-active-background);
          text-color:                  var(selected-active-foreground);
      }
      element alternate.normal {
          background-color:            var(alternate-normal-background);
          text-color:                  var(alternate-normal-foreground);
      }
      element alternate.urgent {
          background-color:            var(alternate-urgent-background);
          text-color:                  var(alternate-urgent-foreground);
      }
      element alternate.active {
          background-color:            var(alternate-active-background);
          text-color:                  var(alternate-active-foreground);
      }
      element-icon {
          background-color:            transparent;
          text-color:                  inherit;
          size:                        24px;
          cursor:                      inherit;
      }
      element-text {
          background-color:            transparent;
          text-color:                  inherit;
          highlight:                   inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.0;
      }

      /*****----- Mode Switcher -----*****/
      mode-switcher{
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      button {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  inherit;
          cursor:                      pointer;
      }
      button selected {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }

      /*****----- Message -----*****/
      message {
          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px 0px 0px 0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      textbox {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  @foreground-colour;
          vertical-align:              0.5;
          horizontal-align:            0.0;
          highlight:                   none;
          placeholder-color:           @foreground-colour;
          blink:                       true;
          markup:                      true;
      }
      error-message {
          padding:                     10px;
          border:                      2px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @background-colour;
          text-color:                  @foreground-colour;
      }
    '';
    home.configFile."rofi/launchers/pdf-launcher/style-1.rasi".text = ''
        /**
       *
       * Author : Aditya Shakya (adi1090x)
       * Github : @adi1090x
       *
       * Rofi Theme File
       * Rofi Version: 1.7.3
       **/

      /*****----- Configuration -----*****/
                        configuration {
                            modi: "drun,run,filebrowser,window";
                            show-icons: true;
                            display-drun: "󰀻";
                            display-run: "";
                            display-filebrowser: "󰉖";
                            display-window: "";
                            display-wallpaper: "󰥶";
                            drun-display-format: "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
                            window-format: "{w} 󰧟 {c} 󰧟 {t}";
                            display-clipboard: "󰅌";
                            display-dmenu: "󰍜";
                            dmenu-display-format: "󰍜";
                        }

      /*****----- Global Properties -----*****/
      @import                          "shared/colors.rasi"
      @import                          "shared/fonts.rasi"

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

      /*****----- Main Window -----*****/
      window {
          /* properties for window widget */
          transparency:                "real";
          location:                    center;
          anchor:                      center;
          fullscreen:                  false;
          width:                       800px;
          x-offset:                    0px;
          y-offset:                    0px;

          /* properties for all widgets */
          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      2px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          cursor:                      "default";
          /* Backgroud Colors */
          background-color:            @background-colour;
          /* Backgroud Image */
          //background-image:          url("/path/to/image.png", none);
          /* Simple Linear Gradient */
          //background-image:          linear-gradient(red, orange, pink, purple);
          /* Directional Linear Gradient */
          //background-image:          linear-gradient(to bottom, pink, yellow, magenta);
          /* Angle Linear Gradient */
          //background-image:          linear-gradient(45, cyan, purple, indigo);
      }

      /*****----- Main Box -----*****/
      mainbox {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     40px;
          border:                      0px solid;
          border-radius:               0px 0px 0px 0px;
          border-color:                @border-colour;
          background-color:            transparent;
          children:                    [ "inputbar", "message", "listview", "mode-switcher" ];
      }

      /*****----- Inputbar -----*****/
      inputbar {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          children:                    [ "prompt", "textbox-prompt-colon", "entry" ];
      }

      prompt {
          enabled:                     true;
          background-color:            inherit;
          text-color:                  inherit;
      }
      textbox-prompt-colon {
          enabled:                     true;
          expand:                      false;
          str:                         "";
          background-color:            inherit;
          text-color:                  inherit;
      }
      entry {
          enabled:                     true;
          background-color:            inherit;
          text-color:                  inherit;
          cursor:                      text;
          placeholder:                 "Select PDF...";
          placeholder-color:           inherit;
      }
      num-filtered-rows {
          enabled:                     true;
          expand:                      false;
          background-color:            inherit;
          text-color:                  inherit;
      }
      textbox-num-sep {
          enabled:                     true;
          expand:                      false;
          str:                         "/";
          background-color:            inherit;
          text-color:                  inherit;
      }
      num-rows {
          enabled:                     true;
          expand:                      false;
          background-color:            inherit;
          text-color:                  inherit;
      }
      case-indicator {
          enabled:                     true;
          background-color:            inherit;
          text-color:                  inherit;
      }

      /*****----- Listview -----*****/
      listview {
          enabled:                     true;
          columns:                     1;
          lines:                       10;
          cycle:                       true;
          dynamic:                     true;
          scrollbar:                   true;
          layout:                      vertical;
          reverse:                     false;
          fixed-height:                true;
          fixed-columns:               true;

          spacing:                     5px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          cursor:                      "default";
      }
      scrollbar {
          handle-width:                10px ;
          handle-color:                @handle-colour;
          border-radius:               10px;
          background-color:            @alternate-background;
      }

      /*****----- Elements -----*****/
      element {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          cursor:                      pointer;
      }
      element normal.normal {
          background-color:            var(normal-background);
          text-color:                  var(normal-foreground);
      }
      element normal.urgent {
          background-color:            var(urgent-background);
          text-color:                  var(urgent-foreground);
      }
      element normal.active {
          background-color:            var(active-background);
          text-color:                  var(active-foreground);
      }
      element selected.normal {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }
      element selected.urgent {
          background-color:            var(selected-urgent-background);
          text-color:                  var(selected-urgent-foreground);
      }
      element selected.active {
          background-color:            var(selected-active-background);
          text-color:                  var(selected-active-foreground);
      }
      element alternate.normal {
          background-color:            var(alternate-normal-background);
          text-color:                  var(alternate-normal-foreground);
      }
      element alternate.urgent {
          background-color:            var(alternate-urgent-background);
          text-color:                  var(alternate-urgent-foreground);
      }
      element alternate.active {
          background-color:            var(alternate-active-background);
          text-color:                  var(alternate-active-foreground);
      }
      element-icon {
          background-color:            transparent;
          text-color:                  inherit;
          size:                        24px;
          cursor:                      inherit;
      }
      element-text {
          background-color:            transparent;
          text-color:                  inherit;
          highlight:                   inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.0;
      }

      /*****----- Mode Switcher -----*****/
      mode-switcher{
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      button {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  inherit;
          cursor:                      pointer;
      }
      button selected {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }

      /*****----- Message -----*****/
      message {
          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px 0px 0px 0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      textbox {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  @foreground-colour;
          vertical-align:              0.5;
          horizontal-align:            0.0;
          highlight:                   none;
          placeholder-color:           @foreground-colour;
          blink:                       true;
          markup:                      true;
      }
      error-message {
          padding:                     10px;
          border:                      2px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @background-colour;
          text-color:                  @foreground-colour;
      }
    '';
    home.configFile."rofi/launchers/calculator/style-1.rasi".text = ''
                        configuration {
                            modi: "drun,run,filebrowser,window,calc";
                            show-icons: true;
                            display-drun: "󰀻";
                            display-calc: "󱖦";
                            display-run: "";
                            display-filebrowser: "󰉖";
                            display-window: "";
                            drun-display-format: "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
                            window-format: "{w} 󰧟 {c} 󰧟 {t}";
                            display-clipboard: "󰅌";
                            display-dmenu: "󰍜";
                            dmenu-display-format: "󰍜";
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
                          width: 800px;
                          border-radius: 10px;
                          border: 3px solid;
                          border-color: @border-colour;
                          padding: 0px;
                          location: center;
                          anchor: center;
                          fullscreen: false;
                          x-offset: 0px;
                          y-offest: 0px;
                          enabled: true;
                          margin: 0px;
                          cursor: "default";
                          background-color: @background-colour;
                        }
                        mainbox {
                            enabled: true;
                            spacing: 10px;
                            margin: 0px;
                            padding: 40px;
                            border: 0px solid;
                            border-radius: 0px 0px 0px 0px;
                            border-color: @border-colour;
                            background-color: transparent;
                            children: [ "inputbar", "message"];
                        }
                        inputbar {
                            enabled: true;
                            spacing: 10px;
                            margin: 0px;
                            padding: 0px;
                            border: 0px solid;
                            border-color: @border-colour;
                            background-color: transparent;
                            text-color: @foreground-colour;
                            children: [ "prompt", "textbox-prompt-colon", "entry" ];
                        }

                        prompt {
                            enabled: true;
                            background-color: inherit;
                            text-color: inherit;
                        }
                        textbox-prompt-colon {
                          enabled: true;
                          expand: false;
                          str: "";
                          background-color: inherit;
                          text-color: inherit;
                        }
                        entry {
                            enabled: true;
                            background-color: inherit;
                            text-color: inherit;
                            cursor: text;
                            placeholder: "Calculate...";
                            placeholder-color: inherit;
                        }
                  num-filtered-rows {
                      enabled:                     true;
                      expand:                      false;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  textbox-num-sep {
                      enabled:                     true;
                      expand:                      false;
                      str:                         "/";
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  num-rows {
                      enabled:                     true;
                      expand:                      false;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  case-indicator {
                      enabled:                     true;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
            scrollbar {
              handle-width:                10px ;
              handle-color:                @handle-colour;
              border-radius:               10px;
              background-color:            @alternate-background;
            }
            element {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          cursor:                      pointer;
      }
      element normal.normal {
          background-color:            var(normal-background);
          text-color:                  var(normal-foreground);
      }
      element normal.urgent {
          background-color:            var(urgent-background);
          text-color:                  var(urgent-foreground);
      }
      element normal.active {
          background-color:            var(active-background);
          text-color:                  var(active-foreground);
      }
      element selected.normal {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }
      element selected.urgent {
          background-color:            var(selected-urgent-background);
          text-color:                  var(selected-urgent-foreground);
      }
      element selected.active {
          background-color:            var(selected-active-background);
          text-color:                  var(selected-active-foreground);
      }
      element alternate.normal {
          background-color:            var(alternate-normal-background);
          text-color:                  var(alternate-normal-foreground);
      }
      element alternate.urgent {
          background-color:            var(alternate-urgent-background);
          text-color:                  var(alternate-urgent-foreground);
      }
      element alternate.active {
          background-color:            var(alternate-active-background);
          text-color:                  var(alternate-active-foreground);
      }
      element-icon {
          background-color:            transparent;
          text-color:                  inherit;
          size:                        24px;
          cursor:                      inherit;
      }
      element-text {
          background-color:            transparent;
          text-color:                  inherit;
          highlight:                   inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.0;
      }

      /*****----- Mode Switcher -----*****/
      mode-switcher{
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      button {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  inherit;
          cursor:                      pointer;
      }
      button selected {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }

      /*****----- Message -----*****/
      message {
          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px 0px 0px 0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      textbox {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  @foreground-colour;
          vertical-align:              0.5;
          horizontal-align:            0.0;
          highlight:                   none;
          placeholder-color:           @foreground-colour;
          blink:                       true;
          markup:                      true;
      }
      error-message {
          padding:                     10px;
          border:                      2px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @background-colour;
          text-color:                  @foreground-colour;
      }
    '';
    home.configFile."rofi/powermenu/style-1.rasi".text = ''
          /**
       *
       * Author : Aditya Shakya (adi1090x)
       * Github : @adi1090x
       *
       * Rofi Theme File
       * Rofi Version: 1.7.3
       **/

      /*****----- Configuration -----*****/
      configuration {
          show-icons:                 false;
      }

      /*****----- Global Properties -----*****/
      @import                          "shared/colors.rasi"
      @import                          "shared/fonts.rasi"

      /*****----- Main Window -----*****/
      window {
          /* properties for window widget */
          transparency:                "real";
          location:                    center;
          anchor:                      center;
          fullscreen:                  false;
          width:                       400px;
          x-offset:                    0px;
          y-offset:                    0px;

          /* properties for all widgets */
          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      2px solid;
          border-radius:               6px;
          border-color:                @selected;
          cursor:                      "default";
          background-color:            @background;
      }

      /*****----- Main Box -----*****/
      mainbox {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     20px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @selected;
          background-color:            transparent;
          children:                    [ "inputbar", "message", "listview" ];
      }

      /*****----- Inputbar -----*****/
      inputbar {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px;
          border-radius:               0px;
          border-color:                @selected;
          background-color:            transparent;
          text-color:                  @foreground;
          children:                    [ "textbox-prompt-colon", "prompt"];
      }

      textbox-prompt-colon {
          enabled:                     true;
          expand:                      false;
          str:                         "";
          padding:                     10px 14px;
          border-radius:               6px;
          background-color:            @urgent;
          text-color:                  @background;
      }
      prompt {
          enabled:                     true;
          padding:                     10px;
          border-radius:               6px;
          background-color:            @active;
          text-color:                  @background;
      }

      /*****----- Message -----*****/
      message {
          enabled:                     true;
          margin:                      0px;
          padding:                     10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @selected;
          background-color:            @background-alt;
          text-color:                  @foreground;
      }
      textbox {
          background-color:            inherit;
          text-color:                  inherit;
          vertical-align:              0.5;
          horizontal-align:            0.0;
          placeholder-color:           @foreground;
          blink:                       true;
          markup:                      true;
      }
      error-message {
          padding:                     10px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @selected;
          background-color:            @background;
          text-color:                  @foreground;
      }

      /*****----- Listview -----*****/
      listview {
          enabled:                     true;
          columns:                     1;
          lines:                       5;
          cycle:                       true;
          dynamic:                     true;
          scrollbar:                   false;
          layout:                      vertical;
          reverse:                     false;
          fixed-height:                true;
          fixed-columns:               true;

          spacing:                     5px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @selected;
          background-color:            transparent;
          text-color:                  @foreground;
          cursor:                      "default";
      }

      /*****----- Elements -----*****/
      element {
          enabled:                     true;
          spacing:                     0px;
          margin:                      0px;
          padding:                     10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @selected;
          background-color:            transparent;
          text-color:                  @foreground;
          cursor:                      pointer;
      }
      element-text {
          background-color:            transparent;
          text-color:                  inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.0;
      }
      element selected.normal {
          background-color:            var(selected);
          text-color:                  var(background);
      }
    '';
    home.configFile."rofi/emoji/style-1.rasi".text = ''
                        configuration {
                            modi: "drun,run,filebrowser,window,emoji";
                            show-icons: true;
                            display-drun: "󰀻";
                            display-emoji: "󰙃";
                            display-run: "";
                            display-filebrowser: "󰉖";
                            display-window: "";
                            drun-display-format: "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
                            window-format: "{w} 󰧟 {c} 󰧟 {t}";
                            display-clipboard: "󰅌";
                            display-dmenu: "󰍜";
                            dmenu-display-format: "󰍜";
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
                          width: 800px;
                          border-radius: 10px;
                          border: 3px solid;
                          border-color: @border-colour;
                          padding: 0px;
                          location: center;
                          anchor: center;
                          fullscreen: false;
                          x-offset: 0px;
                          y-offest: 0px;
                          enabled: true;
                          margin: 0px;
                          cursor: "default";
                          background-color: @background-colour;
                        }
                        mainbox {
                            enabled: true;
                            spacing: 10px;
                            margin: 0px;
                            padding: 40px;
                            border: 0px solid;
                            border-radius: 0px 0px 0px 0px;
                            border-color: @border-colour;
                            background-color: transparent;
                            children: [ "inputbar", "message", "listview" ];
                        }
                        inputbar {
                            enabled: true;
                            spacing: 10px;
                            margin: 0px;
                            padding: 0px;
                            border: 0px solid;
                            border-color: @border-colour;
                            background-color: transparent;
                            text-color: @foreground-colour;
                            children: [ "prompt", "textbox-prompt-colon", "entry" ];
                        }

                        prompt {
                            enabled: true;
                            background-color: inherit;
                            text-color: inherit;
                        }
                        textbox-prompt-colon {
                          enabled: true;
                          expand: false;
                          str: "";
                          background-color: inherit;
                          text-color: inherit;
                        }
                        entry {
                            enabled: true;
                            background-color: inherit;
                            text-color: inherit;
                            cursor: text;
                            placeholder: "Search Emojis...";
                            placeholder-color: inherit;
                        }
                  num-filtered-rows {
                      enabled:                     true;
                      expand:                      false;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  textbox-num-sep {
                      enabled:                     true;
                      expand:                      false;
                      str:                         "/";
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  num-rows {
                      enabled:                     true;
                      expand:                      false;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
                  case-indicator {
                      enabled:                     true;
                      background-color:            inherit;
                      text-color:                  inherit;
                  }
            listview {
                enabled:                     true;
                columns:                     2;
                lines:                       10;
                cycle:                       true;
                dynamic:                     true;
                scrollbar:                   true;
                layout:                      vertical;
                reverse:                     false;
                fixed-height:                true;
                fixed-columns:               true;

                spacing:                     5px;
                margin:                      0px;
                padding:                     0px;
                border:                      0px solid;
                border-radius:               0px;
                border-color:                @border-colour;
                background-color:            transparent;
                text-color:                  @foreground-colour;
                cursor:                      "default";
            }
            scrollbar {
              handle-width:                10px ;
              handle-color:                @handle-colour;
              border-radius:               10px;
              background-color:            @alternate-background;
            }
            element {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          cursor:                      pointer;
      }
      element normal.normal {
          background-color:            var(normal-background);
          text-color:                  var(normal-foreground);
      }
      element normal.urgent {
          background-color:            var(urgent-background);
          text-color:                  var(urgent-foreground);
      }
      element normal.active {
          background-color:            var(active-background);
          text-color:                  var(active-foreground);
      }
      element selected.normal {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }
      element selected.urgent {
          background-color:            var(selected-urgent-background);
          text-color:                  var(selected-urgent-foreground);
      }
      element selected.active {
          background-color:            var(selected-active-background);
          text-color:                  var(selected-active-foreground);
      }
      element alternate.normal {
          background-color:            var(alternate-normal-background);
          text-color:                  var(alternate-normal-foreground);
      }
      element alternate.urgent {
          background-color:            var(alternate-urgent-background);
          text-color:                  var(alternate-urgent-foreground);
      }
      element alternate.active {
          background-color:            var(alternate-active-background);
          text-color:                  var(alternate-active-foreground);
      }
      element-icon {
          background-color:            transparent;
          text-color:                  inherit;
          size:                        24px;
          cursor:                      inherit;
      }
      element-text {
          background-color:            transparent;
          text-color:                  inherit;
          highlight:                   inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.0;
      }

      /*****----- Mode Switcher -----*****/
      mode-switcher{
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      button {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  inherit;
          cursor:                      pointer;
      }
      button selected {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }

      /*****----- Message -----*****/
      message {
          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px 0px 0px 0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      textbox {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  @foreground-colour;
          vertical-align:              0.5;
          horizontal-align:            0.0;
          highlight:                   none;
          placeholder-color:           @foreground-colour;
          blink:                       true;
          markup:                      true;
      }
      error-message {
          padding:                     10px;
          border:                      2px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @background-colour;
          text-color:                  @foreground-colour;
      }
    '';
    home.configFile."rofi/clipboard/style-1.rasi".text = ''
        /**
       *
       * Author : Aditya Shakya (adi1090x)
       * Github : @adi1090x
       *
       * Rofi Theme File
       * Rofi Version: 1.7.3
       **/

      /*****----- Configuration -----*****/
                        configuration {
                            modi: "drun,run,filebrowser,window";
                            show-icons: true;
                            display-drun: "󰀻";
                            display-run: "";
                            display-filebrowser: "󰉖";
                            display-window: "";
                            display-wallpaper: "󰥶";
                            drun-display-format: "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
                            window-format: "{w} 󰧟 {c} 󰧟 {t}";
                            display-clipboard: "󰅌";
                            display-dmenu: "󰍜";
                            dmenu-display-format: "󰍜";
                        }

      /*****----- Global Properties -----*****/
      @import                          "shared/colors.rasi"
      @import                          "shared/fonts.rasi"

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

      /*****----- Main Window -----*****/
      window {
          /* properties for window widget */
          transparency:                "real";
          location:                    center;
          anchor:                      center;
          fullscreen:                  false;
          width:                       800px;
          x-offset:                    0px;
          y-offset:                    0px;

          /* properties for all widgets */
          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      2px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          cursor:                      "default";
          /* Backgroud Colors */
          background-color:            @background-colour;
          /* Backgroud Image */
          //background-image:          url("/path/to/image.png", none);
          /* Simple Linear Gradient */
          //background-image:          linear-gradient(red, orange, pink, purple);
          /* Directional Linear Gradient */
          //background-image:          linear-gradient(to bottom, pink, yellow, magenta);
          /* Angle Linear Gradient */
          //background-image:          linear-gradient(45, cyan, purple, indigo);
      }

      /*****----- Main Box -----*****/
      mainbox {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     40px;
          border:                      0px solid;
          border-radius:               0px 0px 0px 0px;
          border-color:                @border-colour;
          background-color:            transparent;
          children:                    [ "inputbar", "message", "listview", "mode-switcher" ];
      }

      /*****----- Inputbar -----*****/
      inputbar {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          children:                    [ "prompt", "textbox-prompt-colon", "entry" ];
      }

      prompt {
          enabled:                     true;
          background-color:            inherit;
          text-color:                  inherit;
      }
      textbox-prompt-colon {
          enabled:                     true;
          expand:                      false;
          str:                         "";
          background-color:            inherit;
          text-color:                  inherit;
      }
      entry {
          enabled:                     true;
          background-color:            inherit;
          text-color:                  inherit;
          cursor:                      text;
          placeholder:                 "Search Clipboard History...";
          placeholder-color:           inherit;
      }
      num-filtered-rows {
          enabled:                     true;
          expand:                      false;
          background-color:            inherit;
          text-color:                  inherit;
      }
      textbox-num-sep {
          enabled:                     true;
          expand:                      false;
          str:                         "/";
          background-color:            inherit;
          text-color:                  inherit;
      }
      num-rows {
          enabled:                     true;
          expand:                      false;
          background-color:            inherit;
          text-color:                  inherit;
      }
      case-indicator {
          enabled:                     true;
          background-color:            inherit;
          text-color:                  inherit;
      }

      /*****----- Listview -----*****/
      listview {
          enabled:                     true;
          columns:                     1;
          lines:                       10;
          cycle:                       true;
          dynamic:                     true;
          scrollbar:                   true;
          layout:                      vertical;
          reverse:                     false;
          fixed-height:                true;
          fixed-columns:               true;

          spacing:                     5px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          cursor:                      "default";
      }
      scrollbar {
          handle-width:                10px ;
          handle-color:                @handle-colour;
          border-radius:               10px;
          background-color:            @alternate-background;
      }

      /*****----- Elements -----*****/
      element {
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
          cursor:                      pointer;
      }
      element normal.normal {
          background-color:            var(normal-background);
          text-color:                  var(normal-foreground);
      }
      element normal.urgent {
          background-color:            var(urgent-background);
          text-color:                  var(urgent-foreground);
      }
      element normal.active {
          background-color:            var(active-background);
          text-color:                  var(active-foreground);
      }
      element selected.normal {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }
      element selected.urgent {
          background-color:            var(selected-urgent-background);
          text-color:                  var(selected-urgent-foreground);
      }
      element selected.active {
          background-color:            var(selected-active-background);
          text-color:                  var(selected-active-foreground);
      }
      element alternate.normal {
          background-color:            var(alternate-normal-background);
          text-color:                  var(alternate-normal-foreground);
      }
      element alternate.urgent {
          background-color:            var(alternate-urgent-background);
          text-color:                  var(alternate-urgent-foreground);
      }
      element alternate.active {
          background-color:            var(alternate-active-background);
          text-color:                  var(alternate-active-foreground);
      }
      element-icon {
          background-color:            transparent;
          text-color:                  inherit;
          size:                        24px;
          cursor:                      inherit;
      }
      element-text {
          background-color:            transparent;
          text-color:                  inherit;
          highlight:                   inherit;
          cursor:                      inherit;
          vertical-align:              0.5;
          horizontal-align:            0.0;
      }

      /*****----- Mode Switcher -----*****/
      mode-switcher{
          enabled:                     true;
          spacing:                     10px;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      button {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  inherit;
          cursor:                      pointer;
      }
      button selected {
          background-color:            var(selected-normal-background);
          text-color:                  var(selected-normal-foreground);
      }

      /*****----- Message -----*****/
      message {
          enabled:                     true;
          margin:                      0px;
          padding:                     0px;
          border:                      0px solid;
          border-radius:               0px 0px 0px 0px;
          border-color:                @border-colour;
          background-color:            transparent;
          text-color:                  @foreground-colour;
      }
      textbox {
          padding:                     5px 10px;
          border:                      0px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @alternate-background;
          text-color:                  @foreground-colour;
          vertical-align:              0.5;
          horizontal-align:            0.0;
          highlight:                   none;
          placeholder-color:           @foreground-colour;
          blink:                       true;
          markup:                      true;
      }
      error-message {
          padding:                     10px;
          border:                      2px solid;
          border-radius:               6px;
          border-color:                @border-colour;
          background-color:            @background-colour;
          text-color:                  @foreground-colour;
      }
    '';
  };
}
