{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "kiwi-ssg";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "AlexCKunze";
    repo = "kiwi-ssg";
    rev = "v${version}";
    hash = "sha256-IIVzONk5H2vQix6HXnk4m2dsaEn++kBGfBZW/aByFWA=";
  };

  installPhase = ''
    mkdir -p $out/bin
    chmod u+x kiwi-ssg
    mv kiwi-ssg $out/bin
  '';

  meta = with lib; {
    description = "Bash Static Site Generator";
    homepage = "https://github.com/AlexCKunze/kiwi-ssg";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [kinzoku];
    mainProgram = "kiwi-ssg";
    platforms = platforms.all;
  };
}
