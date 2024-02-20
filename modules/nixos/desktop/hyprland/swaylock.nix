{
  config,
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) palette;
  colors = palette;
in {
  security.pam.services.swaylock.text = "auth include login";
  home.programs.swaylock = {
    package = pkgs.swaylock-effects;
    enable = true;
    settings = {
      timestr = "%I:%M %p";
      datestr = "%a, %d %b";
      fade-in = "0";
      screenshots = true;
      clock = true;
      daemonize = true;
      ignore-empty-password = true;
      indicator-idle-visible = true;
      effect-blur = "7x5";
    };
  };
  home.services.swayidle = {
    enable = true;
    timeouts = [
      {
        command = "swaylock -f";
        timeout = 1800;
      }
      {
        command = "hyprctl dispatch dpms off";
        resumeCommand = "hyprctl dispatch dpms on";
        timeout = 2000;
      }
    ];
    events = [
      {
        event = "lock";
        command = "sleep 200sec; hyprctl dispatch dpms off";
      }
    ];
  };
}
