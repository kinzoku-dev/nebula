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
  cfg = config.hardware.audio;
in {
  options.hardware.audio = with types; {
    enable = mkBoolOpt false "Enable or disable pipewire";
  };

  config = mkIf cfg.enable {
    # Enable sound with pipewire.
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      package = inputs.nixpkgs-master.legacyPackages.x86_64-linux.pipewire;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    programs.noisetorch.enable = true;
    environment = {
      systemPackages = [pkgs.pavucontrol pkgs.pulsemixer];
      persist.home.directories = [
        ".local/state/wireplumber"
      ];
    };
  };
}
