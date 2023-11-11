{
  fetchFromGitHub,
  lib,
  stdenv,
}:
stdenv.mkDerivation rec {
  pname = "kiwi-ssg";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "AlexCKunze";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-IIVzONk5H2vQix6HXnk4m2dsaEn++kBGfBZW/aByFWA=";
  };

  installPhase = ''
    mkdir -p $out/bin
    chmod u+x kiwi-ssg
    cp kiwi-ssg $out/bin/
  '';
}
