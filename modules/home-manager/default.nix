{ isServer, ... }:
{
  imports =
    if isServer then
      [
        ./other
        ./packages
        ./services
        ./tui
      ]
    else
      [
        ./gui
        ./other
        ./packages
        ./services
        ./tui
      ];
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
