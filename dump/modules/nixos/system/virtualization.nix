{ lib, pkgs, config, inputs, ... }: {
  options.modules.system.virtualisation = {
    enable = lib.mkEnableOption "virtualisation";
    podman.enable = lib.mkEnableOption "podman";
  };
  config = let cfg = config.modules.system.virtualisation;
  in lib.mkMerge [
    (lib.mkIf cfg.enable {
      virtualisation = {
        podman = {
          enable = true;
          autoPrune.enable = true;
          dockerCompat = true;
          defaultNetwork.settings.dns_enabled = true;
        };
        libvirtd.enable = true;
        spiceUSBRedirection.enable = true;
      };

      networking.firewall.interfaces."podman+".allowedUDPPorts = [ 53 ];

      virtualisation.oci-containers.backend = "podman";

      environment.systemPackages = with pkgs; [
        podman-compose
        podman-desktop
        podman-tui
      ];
    })

    (lib.mkIf config.modules.hardware.graphics.nvidia.enable {
      hardware.nvidia-container-toolkit.enable = true;
    })

    (lib.mkUnlessWsl config {
      environment.systemPackages = with pkgs; [
        inputs.winapps.packages.${system}.winapps
        inputs.winapps.packages.${system}.winapps-launcher # optional
      ];
    })
  ];
}
