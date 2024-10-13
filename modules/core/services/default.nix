{
  ...
}:
{
  imports = [
    ./bluetooth.nix
    ./davfs2.nix
    ./firewall.nix
    ./gnome-keyring.nix
    ./gvfs.nix
    ./kdeconnect.nix
    ./localsend.nix
    ./mullvad-vpn.nix
    ./noisetorch.nix
    ./openssh.nix
    ./printing.nix
    ./ratbagd.nix
    ./sound.nix
    ./udev.nix
    ./webdav.nix
    ./xserver.nix
    ./gnupg.nix
  ];
  # ++ (lib.lists.optionals isServer [
  #   ./server
  # ]);
}
