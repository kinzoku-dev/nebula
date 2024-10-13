{
  pkgs,
  config,
  lib,
  ...
}:
{
  environment = {
    shellAliases =
      {
        inherit (config.hm.programs.bash.shellAliases)
          eza
          ls
          ll
          la
          lla
          ;
      }
      // {
        inherit (config.hm.home.shellAliases)
          t # eza related
          y # yazi
          ;
      };
    systemPackages = with pkgs; [
      curl
      eza
      neovim
      procps
      ripgrep
      yazi
      zoxide
    ];
  };
  programs = {
    bash.interactiveShellInit = config.hm.programs.bash.initExtra;

    # fuck nano 🖕
    nano.enable = lib.mkForce false;
  };
}
