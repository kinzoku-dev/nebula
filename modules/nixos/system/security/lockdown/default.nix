{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.system.security.lockdown;
in {
  options.system.security.lockdown = {
    enable = mkBoolOpt false "Whether or not to lockdown the system for maximum security";
  };

  config = mkIf cfg.enable {
    nix.allowedUsers = ["@wheel"];

    services.openssh = {
      passwordAuthentication = false;
      challengeResponseAuthentication = false;
      extraConfig = ''
        AllowTcpForwarding yes
        X11Forwarding no
        AllowAgentForwarding no
        AllowStreamLocalForwarding no
        AuthenticationMethods publickey
      '';
    };
    fileSystems = {
      "/".options = ["noexec"];
      "/etc/nixos".options = ["noexec"];
      "/srv".options = ["noexec"];
      "/var/log".options = ["noexec"];
    };

    environment = {
      defaultPackages = lib.mkForce []; # disables any non defined packages for this system

      systemPackages = with pkgs; [clamav];
    };
    boot = {
      kernelPackages = mkDefault pkgs.linuxPackages_hardened;
      kernelParams = [
        # Don't merge slabs
        "slab_nomerge"

        # Overwrite free'd pages
        "page_poison=1"

        # Enable page allocator randomization
        "page_alloc.shuffle=1"

        # Disable debugfs
        "debugfs=off"
      ];
      blacklistedKernelModules = [
        # Obscure network protocols
        "ax25"
        "netrom"
        "rose"

        # Old or rare or insufficiently audited filesystems
        "adfs"
        "affs"
        "bfs"
        "befs"
        "cramfs"
        "efs"
        "erofs"
        "exofs"
        "freevxfs"
        "f2fs"
        "hfs"
        "hpfs"
        "jfs"
        "minix"
        "nilfs2"
        "ntfs"
        "omfs"
        "qnx4"
        "qnx6"
        "sysv"
        "ufs"
      ];
      kernel = {
        sysctl = {
          # Hide kptrs even for processes with CAP_SYSLOG
          "kernel.kptr_restrict" = mkOverride 500 2;

          # Disable bpf() JIT (to eliminate spray attacks)
          "net.core.bpf_jit_enable" = mkDefault false;

          # Disable ftrace debugging
          "kernel.ftrace_enabled" = mkDefault false;
        };
      };
    };

    security = {
      lockKernelModules = true;
      protectKernelImage = true;
      allowSimultaneousMultithreading = false;
      forcePageTableIsolation = true;
      unprivilegedUsernsClone = config.virtualisation.containers.enable;
      virtualisation.flushL1DataCache = "always";
      apparmor = {
        enable = true;
        killUnconfinedConfinables = true;
      };
    };
  };
}
