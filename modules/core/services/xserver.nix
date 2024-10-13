{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    xkb = {
      variant = "";
      layout = "us";
    };
    excludePackages = [ pkgs.xterm ];
  };
}
