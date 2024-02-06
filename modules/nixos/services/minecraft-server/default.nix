{
  config,
  options,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.minecraft-server;
in {
  options.minecraft-server = with types; {
    enable = mkBoolOpt false "Enable minecraft minecraft-server";
  };

  config = mkIf cfg.enable {
    services.minecraft-server = {
      enable = true;
      eula = true;
      openFirewall = true;
      declarative = true;
      serverProperties = {
        server-port = 43000;
        gamemode = 0;
        motd = "geeble goo";
        white-list = false;
      };
    };
  };
}
