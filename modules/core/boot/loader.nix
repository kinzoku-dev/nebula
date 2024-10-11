{pkgs, ...}: {
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        devices = ["nodev"];
        theme = pkgs.catppuccin-grub.override {
          flavour = "frappe";
        };
      };
      systemd-boot.enable = false;
      efi = {
        canTouchEfiVariables = true;
      };
    };
  };
}
