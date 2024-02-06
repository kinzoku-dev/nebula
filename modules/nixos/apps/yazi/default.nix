{
  config,
  options,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.yazi;
in {
  options.apps.yazi = with types; {
    enable = mkBoolOpt false "Enable yazi terminal file manager";
  };

  config = mkIf cfg.enable {
    home.programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      settings = {
        manager = {
          layout = [0 1 1];
          sort_by = "alphabetical";
          sort_sensitive = false;
          linemode = "size";
          sort_reverse = false;
          show_hidden = true;
        };
      };
    };

    home.configFile."yazi/theme.toml".source = ./mocha.toml;
    home.configFile."yazi/keymap.toml".source = ./keymap.toml;
  };
}
