{pkgs, ...}: {
  services.displayManager = {
    lightdm.enable = false;
    sddm = {
      enable = true;
      theme = "catppuccin-frappe";
      package = pkgs.kdePackages.sddm;
    };
  };
  environment.systemPackages = [
    (pkgs.catppuccin-sddm.override {
      flavor = "frappe";
      font = "JetBrainsMono Nerd Font";
      fontSize = "12";
      # background = "${../../../assets/wallpapers/dmc5-vergil-awakens.jpg}";
      loginBackground = true;
    })
  ];
}
