{
  config,
  pkgs,
  lib,
  options,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.misc.figlet;
in {
  options.apps.misc.figlet = with types; {
    enable = mkBoolOpt false "Enable figlet";
  };

  config = mkIf cfg.enable {
    home.file."figlet_fonts/ANSI_Shadow.flf".source = ./ANSI_Shadow.flf;
    environment.systemPackages = [
      pkgs.figlet
      pkgs.lolcat
    ];
  };
}
