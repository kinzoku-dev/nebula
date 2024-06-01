{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.shell;
  theme = inputs.nix-colors.colorschemes.${builtins.toString config.desktop.colorscheme};
  colors = theme.palette;
in {
  options.system.shell = with types; {
    shell =
      mkOpt
      (enum [
        "nu"
        "fish"
        "zsh"
      ]) "nu" "What shell to use";
  };

  config = {
    environment.systemPackages = with pkgs; [
      eza
      bat
      nitch
      fd
      ripgrep
      wget
      grc
    ];
    users.defaultUserShell =
      if (cfg.shell == "nu")
      then pkgs.nushell
      else pkgs.${cfg.shell};

    users.users.kinzoku.ignoreShellProgramCheck = true;
    users.users.root.ignoreShellProgramCheck = true;

    system.persist.home = {
      dirs = [
        ".local/share/zoxide"
        ".local/share/atuin"
        ".config/atuin"
      ];
      files = [".zsh_history"];
    };

    home.programs.starship = {
      enable = true;
      enableZshIntegration = false;
      enableNushellIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    home.configFile."starship.toml".source = ./starship.toml;

    environment.shellAliases = {
      ".." = "cd ..";
      tfmt = "treefmt";
      dv = "direnv";
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
      seclipse = "TERM=xterm-256color ssh kinzoku@71.150.126.171";
      nf = "neofetch";
      cl = "clear";
      pm = "pulsemixer";
      v = "fd --type f --hidden --exclude .git | fzf-tmux -p | xargs nvim";
      k = "kubectl";
      # cdf = "cd $(fd . -t d -H | fzf)";
      # zf = "z $(fd . -t d -H | fzf)";
      # nvf = "nvim $(fd . -t f -H | fzf)";
    };

    home.programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = false;
    };

    home.programs.atuin = {
      enable = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
      enableFishIntegration = true;
      flags = ["--disable-up-arrow"];
      settings = {
        enter_accept = true;
        filter_mode = "host";
        search_mode = "fuzzy";
      };
    };

    home.programs.carapace = {
      enable = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
    };

    home.programs.zsh = mkIf (cfg.shell == "zsh") {
      enable = true;
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        custom = "$HOME/.oh-my-zsh/custom";
        plugins = [
          "git"
          "docker-compose"
          "docker"
          "kubectl"
          "ansible"
          "bun"
          "colored-man-pages"
          "fd"
          "fluxcd"
          "fzf"
          "nmap"
          "npm"
          "ripgrep"
          "rust"
          "tmux"
          "gnu-utils"
          "terraform"
        ];
      };
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

        source <(${pkgs.talosctl}/bin/talosctl completion zsh)

        set -o vi
        bindkey -v
        autoload edit-command-line; zle -N edit-command-line
        bindkey '^e' edit-command-line
      '';
    };

    home.programs.nushell = mkIf (cfg.shell == "nu") {
      enable = true;
      shellAliases =
        config.environment.shellAliases
        // {
          ls = "eza";
        };
      extraEnv = ''
        zoxide init nushell | save -f ~/.zoxide.nu
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
        $env.PATH = ($env.PATH | split row (char esep) | prepend /home/${config.user.name}/.apps | append /usr/bin/env)
        $env.DIRENV_LOG_FORMAT = ""

        def , [...packages] {
            nix shell ($packages | each {|s| $"nixpkgs#($s)"})
        }

        def flakeinit [template] {
            nix flake init -t github:nix-community/templates#$template
        }

        source ~/.zoxide.nu
      '';
    };

    home.programs.fish = mkIf (cfg.shell == "fish") {
      enable = true;
      shellAliases = config.environment.shellAliases;
      shellAbbrs = {
        txn = "tx new";
        txa = "tx a";
        txd = "tx detach";
        txk = "tx kill-session";
        txl = "tx list-sessions";
        dva = "direnv allow";
        dvs = "direnv status";
        dvk = "direnv revoke";
        dvr = "direnv reload";
      };
      interactiveShellInit = ''
        set fish_greeting
        fish_vi_key_bindings

        ${pkgs.fluxcd}/bin/flux completion fish | source
        ${pkgs.talosctl}/bin/talosctl completion fish | source
      '';
      plugins = [
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "autopair";
          src = pkgs.fishPlugins.autopair.src;
        }
        {
          name = "colored-man-pages";
          src = pkgs.fishPlugins.colored-man-pages.src;
        }
        {
          name = "fish-kubectl-completions";
          src = pkgs.fetchurl {
            url = "https://github.com/evanlucas/fish-kubectl-completions/blob/main/completions/kubectl.fish";
            sha256 = "06r390wa2g7g5ikwrc4cqikdf4r9yag2ap55sjaxgj5mn89s2qic";
          };
        }
        {
          name = "fish-kubectl-abbr";
          src = pkgs.fetchFromGitHub {
            owner = "lewisacidic";
            repo = "fish-kubectl-abbr";
            rev = "0.1.0";
            hash = "sha256-x4u8tDuNWMOBFK+5KdF1+k2RJd1vFooRcmEkBXCZZ1M=";
          };
        }
      ];
      functions = {
        "," = ''
          for pkg in $argv
              nix shell nixpkgs#$pkg
          end
        '';
      };
    };
  };
}
