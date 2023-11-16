{
  config,
  pkgs,
  options,
  lib,
  ...
}:
with lib;
with lib.nebula; let
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
        dvr = "direnv revoke";
        sz = "source ~/.config/zsh/.zshrc";
        tfmt = "treefmt";
        flui = "sudo nix flake lock --update-input";
        figshad = mkIf config.apps.misc.figlet.enable "figlet -f ~/figlet_fonts/ANSI_Shadow.flf $1";
        ga = mkIf config.apps.tools.git.enable "git add .";
        gc = mkIf config.apps.tools.git.enable "git commit -m ";
        gp = mkIf config.apps.tools.git.enable "git push -u origin";

        lg = mkIf config.apps.tools.git.enable "lazygit";

        czf = "cd \$(find \$(pwd) -type d \( -name node_modules -o -name .git \) -prune -o -name '*'  -type d -print | fzf)";
      };
      initExtra = ''
        eval "$(direnv hook zsh)"
        export DIRENV_LOG_FORMAT=""
        eval "$(starship init zsh)"
        eval "$(zoxide init zsh)"
        export GPG_TTY=$(tty)

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
  };
}
