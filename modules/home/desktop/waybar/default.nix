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
  cfg = config.home.desktop.waybar;
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.home.desktop.colorscheme}) colors;
in {
  options.home.desktop.waybar = with types; {
    enable = mkBoolOpt false "Enable waybar";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs;
      [
        waybar
        pavucontrol
        playerctl
      ]
      ++ (with pkgs.python311Packages; [
        pygobject3
        pygobject-stubs
      ]);

    home.file.".config/waybar/config" = {
      source = ./config;
      onChange = ''
        ${pkgs.busybox}/bin/pkill -SIGUSR2 waybar
      '';
    };

    home.file.".config/waybar/scripts/" = {
      source = ./scripts;
      recursive = true;
    };

    home.file.".config/waybar/style.css" = {
      text = ''
        * {
            font-family: JetBrainsMono Nerd Font;
            font-size: 13px;
            border-radius: 17px;
        }

        #clock,
        #pulseaudio,
        #tray,
        #cpu,
        #memory,
        #custom-spotify,
        #network {
            padding: 5 15px;
            border-radius: 12px;
            background: #${colors.base00};
            color: #${colors.base07};
            margin-top: 8px;
            margin-bottom: 8px;
            margin-left: 10px;
            transition: all 0.3s ease;
        }
        #window {
          background-color: transparent;
          box-shadow: none;
        }
        window#waybar {
          background-color: rgba(0, 0, 0, 0.096);
          border-radius: 17px;
        }
        window * {
          background-color: transparent;
          border-radius: 0px;
        }
        #workspaces button label {
          color: #${colors.base07};
        }
        #workspaces button.active label {
          color: #${colors.base00};
          font-weight: bolder;
        }
        #workspaces button:hover {
          box-shadow: #${colors.base07} 0 0 0 1.5px;
          background-color: #${colors.base00};
          min-width: 50px;
        }
        #workspaces {
          background-color: transparent;
          border-radius: 17px;
          padding: 5 0px;
          margin-top: 3px;
          margin-bottom: 3px;
        }
        #workspaces button {
          background-color: #${colors.base00};
          border-radius: 12px;
          margin-left: 10px;

          transition: all 0.3s ease;
        }
        #workspaces button.active {
          min-width: 50px;
          box-shadow: rgba(0, 0, 0, 0.288) 2 2 5 2px;
          background-color: #${colors.base0F};
          background-size: 400% 400%;
          transition: all 0.3s ease;
          background: linear-gradient(
            58deg,
            #${colors.base0E},
            #${colors.base0E},
            #${colors.base0E},
            #${colors.base0D},
            #${colors.base0D},
            #${colors.base0E},
            #${colors.base08}
          );
          background-size: 300% 300%;
          animation: colored-gradient 20s ease infinite;
        }
        @keyframes colored-gradient {
          0% {
            background-position: 71% 0%;
          }
          50% {
            background-position: 30% 100%;
          }
          100% {
            background-position: 71% 0%;
          }
        }
        #tray menu {
          background-color: #${colors.base00};
          opacity: 0.8;
        }
        #pulseaudio.muted {
          color: #${colors.base08};
          padding-right: 16px;
        }
      '';
      onChange = ''
        ${pkgs.busybox}/bin/pkill -SIGUSR2 waybar
      '';
    };
  };
}
