{
  pkgs,
  nix-output-monitor,
  ...
}: let
  nom = "${nix-output-monitor}/bin/nom";
in
  pkgs.writeShellScriptBin "houston" ''
    cmd_rebuild() {
        echo "🔨 Rebuilding system configuration with $REBUILD_COMMAND"
        $REBUILD_COMMAND switch --flake .# --log-format internal-json -v |& ${nom} --json
    }

    cmd_test() {
        echo "🧪 Building ephemeral system config with $REBUILD_COMMAND"
        $REBUILD_COMMAND test --fast --flake .# --log-format internal-json -v |& ${nom} --json
    }

    #TODO: add option for updating a single input only
    cmd_update() {
        echo "🔒 Updating flake.lock"
        nix flake update
    }

    cmd_clean() {
        echo "🗑 Cleaning and optimizing /nix/store"
        nix store optimise --verbose &&
        nix store gc --verbose
    }

    cmd_usage() {
        cat <<-_EOF
    Usage:
        $PROGRAM rebuild
            *Rebuild the system.
            Must be run as root.
        $PROGRAM test
            Similar to rebuild but faster and not persistent
        $PROGRAM update
            *Update all inputs
            Must be run as root
        $PROGRAM clean
            Garbage collect and optimize /nix/store
        $PROGRAM help
            Display this message

        *Must be in flake directory
    _EOF
    }

    if [[ "$OSTYPE" == "linux"* ]]; then
      REBUILD_COMMAND="nixos-rebuild"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
      REBUILD_COMMAND=darwin-rebuild
    fi

    PROGRAM=sys
    COMMAND="$1"
    case "$1" in
        rebuild|r) shift;       cmd_rebuild ;;
        test|t) shift;          cmd_test ;;
        update|u) shift;        cmd_update ;;
        clean|c) shift;         cmd_clean ;;
        help|--help) shift;     cmd_usage "$@" ;;
        *)              echo "Unknown command: $@" ;;
    esac
    exit 0
  ''
