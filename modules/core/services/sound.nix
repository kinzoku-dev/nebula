{ pkgs, ... }:
{
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber = {
      enable = true;
      extraConfig = {
        disable-autoswitch = {
          "wireplumber.settings" = {
            "bluetooth.autoswitch-to-headset-profile" = "false";
          };
        };
      };
    };
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraLv2Packages = with pkgs; [
      lsp-plugins
      rnnoise-plugin
    ];
  };
}
