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
      font-size = "45";
      timestr = "%I:%M %p";
      datestr = "%a, %d %b";
      fade-in = "0";
      screenshots = true;
      clock = true;
      daemonize = true;
      ignore-empty-password = true;
      indicator-idle-visible = true;
      effect-blur = "7x5";
      indicator-radius = "150";
      indicator-thickness = "10";

      ring-color = "${colors.base07}ff";
      ring-ver-color = "${colors.base07}ff";
      ring-clear-color = "${colors.base07}ff";
      ring-wrong-color = "${colors.base08}ff";
      text-color = "${colors.base05}ff";
      text-clear-color = "${colors.base05}ff";
      text-wrong-color = "${colors.base08}ff";
      inside-color = "${colors.base00}7f";
      inside-wrong-color = "${colors.base01}7f";
      inside-clear-color = "${colors.base00}7f";
      font = "JetBrainsMono Nerd Font";
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
