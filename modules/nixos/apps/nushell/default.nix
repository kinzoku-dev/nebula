{
  config,
  pkgs,
  options,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.nushell;
in {
  options.apps.nushell = with types; {
    enable = mkBoolOpt false "enable or disable nushell";
  };

  config = mkIf cfg.enable {
    users.users.kinzoku.ignoreShellProgramCheck = true;
    users.users.kinzoku.shell = pkgs.nushell;

    home.programs.nushell = {
      enable = true;
      shellAliases = {
        rb = "sudo nixos-rebuild switch --flake .";
        # dv = "direnv";
        # dva = "direnv allow";
        # dvr = "direnv revoke";
        # sz = "source ~/.config/zsh/.zshrc";
        tfmt = "treefmt";
        flui = "sudo nix flake lock --update-input";
        # figshad = mkIf config.apps.misc.figlet.enable "figlet -f ~/figlet_fonts/ANSI_Shadow.flf $1";
        ga = mkIf config.apps.tools.git.enable "git add .";
        gc = mkIf config.apps.tools.git.enable "git commit -m ";
        gp = mkIf config.apps.tools.git.enable "git push -u origin";

        lg = mkIf config.apps.tools.git.enable "lazygit";
        neofetch = "nitch";

        az = "yazi";
      };
      envFile.text = ''
        mkdir ~/.cache/starship
        starship init nu | save -f ~/.cache/starship/init.nu
        zoxide init nushell | save -f ~/.zoxide.nu
      '';
      configFile.text = ''
        use ~/.cache/starship/init.nu
        source ~/.zoxide.nu
      '';
      extraConfig = ''
        $env.config = {
        	show_banner: false,
        }

        def , [...packages] {
            nix shell ($packages | each {|s| $"nixpkgs#($s)"})

        }

        def-env ya [] {
            let tmp = (mktemp -t "yazi-cwd.XXXXX")
                yazi --cwd-file $tmp
                let cwd = (cat -- $tmp)
                if $cwd != "" and $cwd != $env.PWD {
                    cd $cwd
                }
            rm -f $tmp
        }
      '';
    };
  };
}
