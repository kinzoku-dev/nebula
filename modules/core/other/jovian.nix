{
  inputs,
  userinfo,
  ...
}:
{
  imports = [ inputs.jovian-nixos.nixosModules.default ];
  # Jovian NixOS options, specific to the Steam Deck
  jovian = {
    steam = {
      enable = true;
      autoStart = true;
      user = "${userinfo.name}";
      desktopSession = "hyprland";
    };
    devices = {
      steamdeck = {
        enable = true;
        enableGyroDsuService = true;
      };
    };
    decky-loader = {
      enable = true;
      user = "${userinfo.name}";
      stateDir = "/var/lib/decky-loader";
    };
  };
}
