{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "satisfactory-mod-manager";
  version = "3.0.0-beta.1";

  src = fetchFromGitHub {
    owner = "satisfactorymodding";
    repo = "SatisfactoryModManager";
    rev = "v${version}";
    hash = "sha256-A2hHSD1VYryHixau1wFUOa2VUQ0jy/P5J5uVx8QUapc=";
  };

  vendorHash = "sha256-QPgVhw/A4jP8xVR7lJZGT0kj3vpokCA6bfsHUxPdWL0=";

  ldflags = ["-s" "-w"];

  meta = with lib; {
    description = "A mod manager for easy installation of mods and modloader for Satisfactory";
    homepage = "https://github.com/satisfactorymodding/SatisfactoryModManager";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [kinzoku];
    mainProgram = "satisfactory-mod-manager";
  };
}
