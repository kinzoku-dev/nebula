{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
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
          [╔═](bold blue) $username$hostname [═╡](bold blue)
          [║](bold blue) $directory
          [╚═══╡](bold blue) '';

        username = {
          format = "[$user]($style)";
          show_always = true;
        };

        hostname = {
          format = "[@$hostname]($style)";
          style = "bold green";
          ssh_only = false;
        };
      };
    };
  };
}
