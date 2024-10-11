{
  lib,
  hostname,
  ...
}: {
  imports =
    [
      ./dconf.nix
      ./environment.nix
      ./nix.nix
      ./nixpkgs.nix
      ./polkit.nix
      ./xdg.nix
      ./impermanence.nix
      ./security.nix
      ./virtualization.nix
    ]
    ++ (lib.lists.optionals (hostname == "SATELLITE") [
      ./jovian.nix
    ]);
}
