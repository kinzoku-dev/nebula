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
    environment.systemPackages = with pkgs; [virtiofsd];
    virtualisation.libvirtd.enable = true;
    programs.virt-manager.enable = true;

    user.extraGroups = ["libvirtd"];

    system.persist.root.cache = ["/var/lib/libvirt"];
  };
}
