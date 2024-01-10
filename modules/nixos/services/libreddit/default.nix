{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.libreddit;
in {
  options.libreddit = with types; {
    enable = mkBoolOpt false "Enable libreddit";
  };

  config = mkIf cfg.enable {
    services.libreddit = {
      enable = true;
      address = "0.0.0.0";
      port = 9692;
    };
  };
}
