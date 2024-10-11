{
  pkgs,
  hostname,
  isServer,
  ...
}: {
  boot = {
    consoleLogLevel = 1;
    kernelParmas = ["split_lock_detect=off"];
    extraModulePackages = with pkgs; (lib.lists.optionals (hostname == "NOVA") [linuxKernel.packages.linux_xanmod.xpadneo]);
    kernelPackages =
      if (hostname == "SATELLITE")
      then pkgs.linuxPackages_jovian
      else if isServer
      then pkgs.linuxPackages_hardened
      else pkgs.linuxPackages_xanmod;
    supportedFilesystems = ["ntfs"];
    kernelModules = [
      "udev"
      "xpadneo"
      "hid-nintendo"
    ];
  };
}
