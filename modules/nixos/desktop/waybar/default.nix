{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.desktop.waybar;
  inherit (inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme}) palette;
  colors = palette;
in {
  options.desktop.waybar = with types; {
    enable = mkBoolOpt false "Enable waybar";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      blueman
      networkmanagerapplet
      wlogout
    ];

    home.configFile."waybar/scripts" = {
      source = ./scripts;
      recursive = true;
      executable = true;
    };

    home.programs.waybar = let
      wbConfig = import ./config.nix {inherit config colors;};
      wbStyle = import ./style.nix {inherit colors;};
    in {
      enable = true;
      package = inputs.nixpkgs-master.legacyPackages.x86_64-linux.waybar;
      settings = wbConfig;
      style = wbStyle;
    };
  };
}
