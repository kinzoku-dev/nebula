{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.home.desktop.mako;
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.home.desktop.colorscheme}) colors;
in {
  options.home.desktop.mako = with types; {
    enable = mkBoolOpt false "Enable or disable mako";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      mako
      libnotify
    ];

    home.file.".config/mako/config" = {
      text = ''
        background-color=#${colors.base00}
        text-color=#${colors.base05}
        border-color=#${colors.base0D}
        progress-color=over #${colors.base02}
        border-radius=15
        default-timeout=5000

        [urgency=high]
        border-color=#${colors.base09}
      '';
      onChange = ''
        ${pkgs.busybox}/bin/pkill -SIGUSR2 mako
      '';
    };
  };
}
