{
  lib,
  stdenv,
  fetchFromGitHub,
}:
stdenv.mkDerivation rec {
  pname = "grub";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "grub";
    rev = "v${version}";
    hash = "sha256-/bSolCta8GCZ4lP0u5NVqYQ9Y3ZooYCNdTwORNvR7M0=";
  };

  installPhase = ''
    mkdir -p $out
    cp -R ./src/catppuccin-mocha-grub-theme/* $out/
  '';

  meta = with lib; {
    description = "Soothing pastel theme for Grub2";
    homepage = "https://github.com/catppuccin/grub";
    license = licenses.mit;
    maintainers = with maintainers; [kinzoku];
    mainProgram = "grub";
    platforms = platforms.all;
  };
}
