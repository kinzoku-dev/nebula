{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.virtualisation.vm;
in {
  options.virtualisation.vm = with types; {
    enable = mkBoolOpt false "enable vm";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [pkgs.gnome.gnome-boxes];
    virtualisation.libvirtd.enable = true;
    user.extraGroups = ["libvirtd"];
  };
}
