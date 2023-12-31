{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.hardware.graphics;
in {
  options.hardware.graphics = with types; {
    enable = mkBoolOpt false "Enable graphics";
    gpu = mkOpt (enum ["amd" "nvidia"]) "nvidia" "Which gpu to configure";
  };

  config = let
    gpuDriver =
      if cfg.gpu == "amd"
      then "amdgpu"
      else "nvidia";
  in
    mkIf cfg.enable {
      services.xserver.videoDrivers = [
        "${gpuDriver}"
      ];
      hardware.nvidia = mkIf (cfg.gpu == "nvidia") {
        modesetting.enable = true;
      };

      hardware = {
        opengl = {
          enable = true;
          driSupport = true;
          driSupport32Bit = true;
          extraPackages = [pkgs.mesa.drivers];
        };
      };
    };
}
