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
    shell = mkOpt (enum ["nu" "zsh"]) "zsh" "What shell to use";
  };

  config = {
    environment.systemPackages = with pkgs; [
      eza
      bat
      nitch
      fd
      ripgrep
      wget
    ];

    users.defaultUserShell =
      if cfg.shell == "nu"
      then pkgs.nushell
      else pkgs.zsh;
    users.users.root.shell = pkgs.bashInteractive;
    users.users.kinzoku.ignoreShellProgramCheck = true;

    home.programs.starship = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      enableBashIntegration = true;
    };
    home.configFile."starship.toml".source = ./starship.toml;

    environment.shellAliases = {
      ".." = "cd ..";
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
      spoodle = "ssh poodle@mc.theduckpond.xyz -p 42069";
      tx = "tmux";
      hss = "hugo server --noHTTPCache";
      vesktop = "vesktop --disable-gpu";
      ssh = "TERM=xterm-256color ssh";
      seclipse = "TERM=xterm-256color ssh kinzoku@71.150.126.171";
      nf = "neofetch";
      # cdf = "cd $(fd . -t d -H | fzf)";
      # zf = "z $(fd . -t d -H | fzf)";
      # nvf = "nvim $(fd . -t f -H | fzf)";
    };

    home.programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };

    home.programs.atuin = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      settings = {
        enter_accept = true;
        filter_mode_shell_up_key_binding = "session";
        filter_mode = "session";
      };
    };

    home.programs.carapace = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
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
          "," = "shellpkg";
        };
      initExtra = ''
        export XDG_DATA_DIRS=${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS

        function flakeinit() {
            nix flake init -t github:nix-community/templates#$1
        }

        function ,() {
            nix shell nixpkgs#$1
        }

        set -o vi
        bindkey -v
        autoload edit-command-line; zle -N edit-command-line
        bindkey '^e' edit-command-line
      '';
    };

    home.programs.nushell = mkIf (cfg.shell == "nu") {
      enable = true;
      shellAliases = config.environment.shellAliases // {ls = "eza";};
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
        let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
        }
        $env.config = {
        	show_banner: false
            edit_mode: vi
            completions: {
                quick: true
                partial: true
                algorithm: "fuzzy"
                case_sensitive: false
                external: {
                    enable: true
                    max_results: 100
                    completer: $carapace_completer # check 'carapace_completer'
                }
            }
        }
        $env.PATH = ($env.PATH | split row (char esep) | prepend /home/myuser/.apps | append /usr/bin/env)
        $env.DIRENV_LOG_FORMAT = ""

        def , [...packages] {
            nix shell ($packages | each {|s| $"nixpkgs#($s)"})
        }

        def flakeinit [template] {
            nix flake init -t github:nix-community/templates#$template
        }
      '';
    };
  };
}
