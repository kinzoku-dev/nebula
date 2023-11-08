{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.hardware.audio;
in {
  options.hardware.audio = with types; {
    enable = mkBoolOpt false "Enable or disable pipewire";
  };

  config = mkIf cfg.enable {
    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };
    # services.actkbd = {
    #   enable = true;
    #   bindings = [
    #     {
    #       keys = [121];
    #       events = ["key"];
    #       command = "/run/current-system/sw/bin/runuser -l kinzoku -c 'amixer -q set Master toggle'";
    #     }
    #     {
    #       keys = [122];
    #       events = ["key"];
    #       command = "/run/current-system/sw/bin/runuser -l kinzoku -c 'amixer -q set Master 5%- unmute'";
    #     }
    #     {
    #       keys = [123];
    #       events = ["key"];
    #       command = "/run/current-system/sw/bin/runuser -l kinzoku -c 'amixer -q set Master 5%+ unmute'";
    #     }
    #   ];
    # };
  };
}
