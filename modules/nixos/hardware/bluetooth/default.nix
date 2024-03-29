{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.hardware.bluetoothctl;
in {
  options.hardware.bluetoothctl = with types; {
    enable = mkBoolOpt false "Enable bluetooth";
  };

  config = mkIf cfg.enable {
    hardware = {
      bluetooth.enable = true; # enables support for Bluetooth
      bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
    };
    services.blueman.enable = true;

    system.persist.root.dirs = ["/var/lib/bluetooth"];
  };
}
