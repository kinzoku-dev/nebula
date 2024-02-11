{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "sddm";
  version = "unstable-2023-10-27";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "sddm";
    rev = "a13cf43fe05a6c463a7651eb2d96691a36637913";
    hash = "sha256-tyuwHt48cYqG5Pn9VHa4IB4xlybHOxPmhdN9eae36yo=";
  };

  installPhase = ''
    mkdir -p $out
    cp -R ./src/catppuccin-mocha/* $out/
  '';
}
