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
    gpu = mkOpt (enum ["amd" "nvidia" "integrated"]) "nvidia" "Which gpu to configure";
    nvidiaOffload = {
      enable = mkBoolOpt false "Enable nvidia offload via PRIME";
      intelBusId = mkOpt str "PCI:0:2:0" "Intel Bus ID";
      nvidiaBusId = mkOpt str "PCI:14:0:0" "Intel Bus ID";
    };
  };

  config = let
    gpuDriver =
      if cfg.gpu == "amd"
      then "amdgpu"
      else if "nvidia";
  in
    mkIf cfg.enable {
      services.xserver.videoDrivers = [
        (lib.optionalString (cfg.gpu != "integrated") "${gpuDriver}")
      ];
      boot.initrd.kernelModules = [
        (lib.optionalString (cfg.gpu == "amd") "amdgpu")
      ];
      hardware.nvidia = mkIf (cfg.gpu == "nvidia") {
        modesetting.enable = true;
        prime = mkIf cfg.nvidiaOffload.enable {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
          intelBusId = "${cfg.nvidiaOffload.intelBusId}";
          nvidiaBusId = "${cfg.nvidiaOffload.nvidiaBusId}";
        };
      };

      environment.systemPackages = mkIf cfg.nvidiaOffload.enable [
        (pkgs.writeShellScriptBin "prime-run" ''
          export __NV_PRIME_RENDER_OFFLOAD=1
          export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
          export __GLX_VENDOR_LIBRARY_NAME=nvidia
          export __VK_LAYER_NV_optimus=NVIDIA_only
          exec "$@"
        '')
      ];

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
