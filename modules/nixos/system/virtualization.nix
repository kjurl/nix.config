{ lib, pkgs, config, inputs, ... }:
let cfg = config.modules.system.virtualisation;
in {
  # imports = [ ./container.tiny11.nix ];
  options.modules.system.virtualisation = {
    enable = lib.mkEnableOption "virtualisation";
    podman.enable = lib.mkEnableOption "podman";
  };
  config = lib.mkMerge [
    (lib.mkIf cfg.enable {
      # Enable Podman
      virtualisation = {
        podman = {
          enable = true;
          autoPrune.enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
        libvirtd.enable = false;
        spiceUSBRedirection.enable = true;
      };

      networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ];

      virtualisation.oci-containers.backend = "podman";

      environment.systemPackages = with pkgs; [
        # qemu
        podman-compose
        podman-desktop
        podman-tui

        inputs.winapps.packages.${system}.winapps
        inputs.winapps.packages.${system}.winapps-launcher # optional
      ];
    })

    (lib.mkIf config.modules.hardware.graphics.nvidia.enable {
      hardware.nvidia-container-toolkit.enable = true;
    })
  ];
}
