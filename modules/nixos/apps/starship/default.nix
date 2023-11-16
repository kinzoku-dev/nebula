{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.starship;
in {
  options.apps.starship = with types; {
    enable = mkBoolOpt false "enable starship shell prompt";
  };

  config = mkIf cfg.enable {
    home.programs.starship = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      settings = {
        format = ''
          [//=](bold blue) $username$hostname [<>](bold blue) $directory $fill ($nix_shell)$custom
          [|>](bold blue) '';

        username = {
          format = "[$user]($style)";
          show_always = true;
        };

        hostname = {
          format = "[@$hostname]($style)";
          style = "bold green";
          ssh_only = false;
        };
        custom = {
          nix_inspect = let
            excluded = [
              "kitty"
              "imagemagick"
              "ncurses"
              "user-environment"
              "pciutils"
              "binutils-wrapper"
            ];
          in {
            disabled = false;
            when = "test -z $IN_NIX_SHELL";
            command = "${(lib.getExe pkgs.nebula.nix-inspect)} ${(lib.concatStringsSep " " excluded)}";
            format = "[($output <- )$symbol]($style) ";
            symbol = " ";
            style = "bold blue";
          };
        };
        fill = {
          symbol = " ";
          disabled = false;
        };
      };
    };
  };
}
