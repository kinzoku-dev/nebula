{
  pkgs,
  nix-output-monitor,
  ...
}: let
  nom = "${nix-output-monitor}/bin/nom";
in
  pkgs.writeShellScriptBin "houston" ''

    cmd_rebuild() {
        if [[ -z "$2" ]]; then
          JOBS="4"
        elif [[ "$2" =~ ^[0-9]+$ ]]; then
          JOBS="$2"
        else
          echo "Error: Jobs argument must be either null or a number"
        fi
        echo "🔨 Rebuilding system configuration with $REBUILD_COMMAND"
        $REBUILD_COMMAND switch --flake .# -j $JOBS --log-format internal-json -v |& ${nom} --json
    }

    cmd_test() {
        if [[ -z "$2" ]]; then
          JOBS="4"
        elif [[ "$2" =~ ^[0-9]+$ ]]; then
          JOBS="$2"
        else
          echo "Error: Jobs argument must be either null or a number"
        fi
        echo "🧪 Building ephemeral system config with $REBUILD_COMMAND"
        $REBUILD_COMMAND test --fast --flake .# -j $JOBS --log-format internal-json -v |& ${nom} --json
    }

    #TODO: add option for updating a single input only
    cmd_update() {
        echo "🔒 updating flake.lock"
        nix flake update
    }

    cmd_clean() {
        echo "🗑 cleaning and optimizing /nix/store"
        nix store optimise --verbose &&
        nix store gc --verbose
    }

    cmd_usage() {
        cat <<-_eof
    usage:
        $program rebuild
            *rebuild the system.
            must be run as root.
        $program test
            similar to rebuild but faster and not persistent
        $program update
            *update all inputs
            must be run as root
        $program clean
            garbage collect and optimize /nix/store
        $program help
            display this message

        *must be in flake directory
    _eof
    }

    if [[ "$ostype" == "linux"* ]]; then
      rebuild_command=nixos-rebuild
    elif [[ "$ostype" == "darwin"* ]]; then
      rebuild_command=darwin-rebuild
    fi

    program=sys
    command="$1"
    case "$1" in
        rebuild|r) shift;       cmd_rebuild ;;
        test|t) shift;          cmd_test ;;
        update|u) shift;        cmd_update ;;
        clean|c) shift;         cmd_clean ;;
        help|--help) shift;     cmd_usage "$@" ;;
        *)              echo "unknown command: $@" ;;
    esac
    exit 0
  ''
