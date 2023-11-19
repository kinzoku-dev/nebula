{
  pkgs,
  writeShellScriptBin,
}: let
  dots = "/home/kinzoku/dev/nebula";
in (writeShellScriptBin "houston" ''
  pushd ${dots}
  untracked_files=$(git ls-files --exclude-standard --others .)
  if [ -n "$untracked_files" ]; then
    git add "$untracked_files"
  fi

  flake() {
      echo "What would you like to do?"
      action_flake=$(${pkgs.gum}/bin/gum choose "Update" "Rebuild" "Update Input")

      cmd_rebuild() {
        echo "Roger, rebuilding system configuration"
        sudo nixos-rebuild switch --flake .#
      }

      cmd_update() {
        echo "Roger, updating flake.lock"
        sudo nix flake update
      }

      cmd_update_input() {
          echo "Type the name of the input you would like to update"
          fl_input=$(${pkgs.gum}/bin/gum input)
          echo "Roger, updating input"
          sudo nix flake lock --update-input $fl_input
      }

      case $action_flake in
        "Rebuild")
            cmd_rebuild;;
        "Update")
            cmd_update;;
        "Update Input")
            cmd_update_input;;
        *)
            echo "Unknown option";;
      esac
  }

  programs() {
      echo "What would you like to do?"
      action_program=$(${pkgs.gum}/bin/gum choose "Launch" "Reload")

      cmd_launch() {
          prog=$(${pkgs.gum}/bin/gum input --placeholder "Type the program name...")
          $prog & disown
      }

      cmd_reload() {
          prog=$(${pkgs.gum}/bin/gum input --placeholder "Type the program name...")
          proc=$(${pkgs.gum}/bin/gum input --placeholder "Type the name of the process running the program. (leave blank if it's the same as the command)")
          if [ -z $proc ]; then
            ${pkgs.busybox}/bin/pkill $prog
          else
            ${pkgs.busybox}/bin/pkill $proc
          fi
          $prog & disown
      }

      case $action_program in
        "Launch")
            cmd_launch;;
        "Reload")
            cmd_reload;;
        *)
            echo "Unknown option";;
      esac
  }


  prompt() {
      echo "Houston speaking, what are you trying to get to?"
      choice=$(${pkgs.gum}/bin/gum choose "Flake" "Programs" "Exit")

      case $choice in
      "Flake")
        flake
      prompt;;
      "Programs")
          programs
          prompt;;
      "Exit")
          exit 0;;
      *)
          echo "Sorry, I didn't understand you.";;
      esac
  }

  prompt


  popd
'')
