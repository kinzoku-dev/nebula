{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.hardware.nvidia;
in {
  options.hardware.nvidia = with types; {
    enable = mkBoolOpt false "Enable or disable nvidia graphics";
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = mkIf config.system.xserver.enable ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
    };
    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
      };
    };
  };
}
