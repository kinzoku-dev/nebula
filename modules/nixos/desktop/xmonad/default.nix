{
  config,
  pkgs,
  options,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.xmonad;
in {
  options.desktop.xmonad = with types; {
    enable = mkBoolOpt false "Enable or disable xmonad";
  };

  config = mkIf cfg.enable {
    home.extraOptions.xsession.windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
      extraPackages = hp: [
        hp.dbus
        hp.monad-logger
        hp.xmonad-contrib
      ];
    };

    services.xserver.windowManager.xmonad.enable = true;

    environment.systemPackages = with pkgs; [
      dmenu
      flameshot
      xmonad-log
      xorg.xhost
    ];
    home.programs.xmobar = let
      inherit (config.colorscheme) colors;
    in {
      enable = true;
      extraConfig = ''
        Config
          { font = "JetBrains Mono 10"
          , additionalFonts = [ "Font Awesome 6 Free Solid 12" ]
          , position = TopSize C 99 30
          , bgColor = "#11111b"
          , fgColor = "#${colors.base05}"
          , allDesktops = True
          , persistent = True
          , lowerOnStart = True
          , commands =
            [ Run Cpu ["-t", "<fn=1></fn> <fc=#89b4fa><total>%</fc>"] 10
            , Run Memory ["-t","<fn=1></fn> <fc=#89b4fa><usedratio>%</fc>"] 10
            , Run Date "<fn=1></fn> <fc=#89b4fa>%D %I:%M %p</fc>" "date" 10
            , Run XMonadLog
            , Run Alsa "default" "Master"
                        [ "--template", "<fn=1></fn> <fc=#89b4fa><volumestatus></fc>"
                        , "--suffix"  , "True"
                        , "--"
                        , "--on", ""
                        ]
          ]
          , sepChar = "%"
          , alignSep = "}{"
          , template    = "  %XMonadLog% }{ %cpu% | %memory% | %alsa:default:Master% | %date%  "
          }
      '';
    };
  };
}
