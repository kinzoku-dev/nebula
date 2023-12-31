{
  config,
  options,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.vscode;
in {
  options.apps.vscode = with types; {
    enable = mkBoolOpt false "Enable vscode";
  };

  config = mkIf cfg.enable {
    home.programs.vscode = {
      enable = true;
      package = (
        pkgs.vscodium.overrideAttrs {
          desktopItems = [
            (pkgs.makeDesktopItem {
              name = "vscodium";
              desktopName = "VSCodium";
              exec = "codium --ozone-platform=x11";
              icon = "vscode";
              startupWMClass = "VSCodium";
              genericName = "Text Editor";
              keywords = ["vscode"];
              categories = ["Utility" "TextEditor" "Development" "IDE"];
            })
          ];
        }
      );
      # code --ozone-platform=x11
      extensions = with pkgs.vscode-extensions; [
        sumneko.lua
        golang.go
        rust-lang.rust-analyzer
        ms-dotnettools.csharp
        vscodevim.vim
      ];
    };
  };
}
