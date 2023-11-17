{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.shell;
in {
  options.system.shell = with types; {
    shell = mkOpt (enum ["nushell" "zsh"]) "zsh" "What shell to use";
  };

  config = {
    environment.systemPackages = with pkgs; [
      eza
      bat
      nitch
      fzf
      fd
      ripgrep
      wget
    ];

    users.defaultUserShell = pkgs.${cfg.shell};
    users.users.root.shell = pkgs.bashInteractive;
    users.users.kinzoku.ignoreShellProgramCheck = true;

    home.programs.starship = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
    home.configFile."starship.toml".source = ./starship.toml;

    environment.shellAliases = {
      ".." = "cd ..";
      neofetch = "nitch";
      tfmt = "treefmt";
      dv = "direnv";
      dva = "direnv allow";
      dvr = "direnv revoke";
      rb = "sudo nixos-rebuild switch --flake .";
      flui = "sudo nix flake lock --update-input";
      ga = "git add .";
      gc = "git commit -m ";
      gp = "git push -u origin";
      lg = "lazygit";
      az = "yazi";
    };

    home.programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    home.programs.zsh = mkIf (cfg.shell == "zsh") {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      dotDir = ".config/zsh";
      shellAliases =
        config.environment.shellAliases
        // {
          sz = "source ~/.config/zsh/.zshrc";
          cat = "bat";
          ls = "eza";
        };
      initExtra = ''
        eval "$(direnv hook zsh)"
        export DIRENV_LOG_FORMAT=""
        eval "$(starship init zsh)"
        eval "$(zoxide init zsh)"

        function ya() {
            tmp="$(mktemp -t "yazi-cwd.XXXXX")"
            yazi --cwd-file="$tmp"
            if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                cd -- "$cwd"
            fi
            rm -f -- "$tmp"
        }
      '';
    };

    home.programs.nushell = mkIf (cfg.shell == "nushell") {
      enable = true;
      shellAliases = config.environment.shellAliases // {ls = "ls";};
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
