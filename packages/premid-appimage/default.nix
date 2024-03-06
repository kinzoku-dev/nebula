{
  pkgs,
  fetchurl,
  ...
}:
pkgs.appimageTools.wrapType1 {
  name = "premid";
  src = fetchurl {
    url = "https://github.com/PreMiD/Linux/releases/download/v2.3.4/PreMiD-Portable.AppImage";
    hash = "sha256-HVdR2bGi/MlV4FWMHwP5XHw+sv7donENIgxxht9h/hY=";
  };
  extraPkgs = pkgs: with pkgs; [];
}
