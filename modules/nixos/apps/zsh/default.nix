{
  config,
  pkgs,
  options,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.zsh;
in {
  options.apps.zsh = with types; {
    enable = mkBoolOpt false "enable or disable zsh";
  };

  config = mkIf cfg.enable {
    users.users.kinzoku.ignoreShellProgramCheck = true;
    users.users.kinzoku.shell = pkgs.zsh;

    home.programs.zsh = let
      inherit (config.colorscheme) colors;
    in {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      dotDir = ".config/zsh";
      shellAliases = {
        rb = "sudo nixos-rebuild switch --flake .";
        dv = "direnv";
        dva = "direnv allow";
        sz = "source ~/.config/zsh/.zshrc";
        tfmt = "treefmt";
        flui = "sudo nix flake lock --update-input";
        figshad = mkIf config.apps.misc.figlet.enable "figlet -f ~/figlet_fonts/ANSI_Shadow.flf $1";
        ga = mkIf config.apps.tools.git.enable "git add .";
        gc = mkIf config.apps.tools.git.enable "git commit -m ";
        gp = mkIf config.apps.tools.git.enable "git push -u origin";

        lg = mkIf config.apps.tools.git.enable "lazygit";
      };
      initExtra = ''
        eval "$(direnv hook zsh)"
        export DIRENV_LOG_FORMAT=""
        eval "$(starship init zsh)"
        eval "$(zoxide init zsh)"

        echo "${colors.base00}"
      '';
    };
    home.programs.starship = {
      enable = true;
      settings = {
        format = let
          git = "$git_branch$git_commit$git_state$git_status";
          cloud = "$aws$gcloud$openstack";
        in ''
          $username$hostname($shlvl)($cmd_duration) $fill ($nix_shell)$custom
          $directory(${git})(- ${cloud}) $fill $time
          $jobs$character
        '';

        fill = {
          symbol = " ";
          disabled = false;
        };

        # Core
        username = {
          format = "[$user]($style)";
          show_always = true;
        };
        hostname = {
          format = "[@$hostname]($style) ";
          ssh_only = false;
          style = "bold green";
        };
        shlvl = {
          format = "[$shlvl]($style) ";
          style = "bold cyan";
          threshold = 2;
          repeat = true;
          disabled = false;
        };
        cmd_duration = {
          format = "took [$duration]($style) ";
        };

        directory = {
          format = "[$path]($style)( [$read_only]($read_only_style)) ";
        };
        nix_shell = {
          format = "[($name \\(develop\\) <- )$symbol]($style) ";
          impure_msg = "";
          symbol = " ";
          style = "bold red";
        };
        custom = {
          nix_inspect = let
            excluded = [
              "kitty"
              "imagemagick"
              "ncurses"
              "user-environment"
              "pciutils"
              "binutils-wrapper"
            ];
          in {
            disabled = false;
            when = "test -z $IN_NIX_SHELL";
            command = "${(lib.getExe pkgs.custom.nix-inspect)} ${(lib.concatStringsSep " " excluded)}";
            format = "[($output <- )$symbol]($style) ";
            symbol = " ";
            style = "bold blue";
          };
        };

        character = {
          error_symbol = "[~~>](bold red)";
          success_symbol = "[->>](bold green)";
          vimcmd_symbol = "[<<-](bold yellow)";
          vimcmd_visual_symbol = "[<<-](bold cyan)";
          vimcmd_replace_symbol = "[<<-](bold purple)";
          vimcmd_replace_one_symbol = "[<<-](bold purple)";
        };

        time = {
          format = "\\\[[$time]($style)\\\]";
          disabled = false;
        };

        # Cloud
        gcloud = {
          format = "on [$symbol$active(/$project)(\\($region\\))]($style)";
        };
        aws = {
          format = "on [$symbol$profile(\\($region\\))]($style)";
        };

        # Icon changes only \/
        aws.symbol = "  ";
        conda.symbol = " ";
        dart.symbol = " ";
        directory.read_only = " ";
        docker_context.symbol = " ";
        elixir.symbol = " ";
        elm.symbol = " ";
        gcloud.symbol = " ";
        git_branch.symbol = " ";
        golang.symbol = " ";
        hg_branch.symbol = " ";
        java.symbol = " ";
        julia.symbol = " ";
        memory_usage.symbol = "󰍛 ";
        nim.symbol = "󰆥 ";
        nodejs.symbol = " ";
        package.symbol = "󰏗 ";
        perl.symbol = " ";
        php.symbol = " ";
        python.symbol = " ";
        ruby.symbol = " ";
        rust.symbol = " ";
        scala.symbol = " ";
        shlvl.symbol = "";
        swift.symbol = "󰛥 ";
        terraform.symbol = "󱁢";
      };
    };
  };
}
