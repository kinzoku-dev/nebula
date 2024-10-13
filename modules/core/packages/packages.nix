{
  pkgs,
  inputs,
  lib,
  hostname,
  ...
}:
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
  environment.systemPackages =
    with pkgs;
    [
      bash
      gamescope
      lshw
      f3d
    ]
    ++ (lib.lists.optionals (hostname == "SATELLITE") [
      steamdeck-firmware
      jupiter-dock-updater-bin
    ]);

  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
    ];
    packages = [
      "com.github.tchx84.Flatseal"
      "org.freedesktop.Sdk/x86_64/23.08"
      "io.itch.itch"
      "io.github.lime3ds.Lime3DS"
    ];
  };
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "NerdFontsSymbolsOnly"
      ];
    })
  ];
}
