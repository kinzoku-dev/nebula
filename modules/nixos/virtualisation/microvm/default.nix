{
  options,
  config,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.virtualisation.microvm;
in {
  imports = with inputs; [
    microvm.nixosModules.host
  ];

  options.virtualisation.microvm = with types; {
    enable = mkBoolOpt false "Enable microvm support";
  };

  config = mkIf cfg.enable {
    system.persist.root.dirs = [
      "/var/lib/microvms"
    ];
  };
}
