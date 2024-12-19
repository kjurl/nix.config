# https://nixos.wiki/wiki/Nvidia#Optimus
# https://github.com/NixOS/nixos-hardware/tree/master/common/gpu/nvidia
# https://github.com/mogria/nixos-config/blob/master/hardware/nvidia.nix
# https://discourse.nixos.org/t/laptop-graphics-card-not-detected-by-nixos-generate-config/22450
{ lib, pkgs, config, ... }:
let cfg = config.modules.hardware.graphics.nvidia;
in {
  options.modules.hardware.graphics.nvidia = {
    enable = lib.mkEnableOption "nvidial functionality";
    disable = lib.mkOption {
      description = "disable nvidia gpu";
      type = lib.types.bool;
      default = false;
    };
    prime = {
      enable = lib.mkEnableOption "nvidia prime";
      # https://wiki.nixos.org/wiki/Nvidia#Configuring_Optimus_PRIME:_Bus_ID_Values_(Mandatory)
      intelBusId = lib.mkOption {
        description = "intel BUS ID";
        type = lib.types.str;
      };
      nvidiaBusId = lib.mkOption {
        description = "nvidia BUS ID";
        type = lib.types.str;
      };
    };
  };
  config = let
    inherit (lib) mkIf;
    nvidia-offload = pkgs.writeScriptBin "nividia-offload" # bash

      ''
        export __NV_PRIME_RENDER_OFFLOAD=1
        export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
        export __GLX_VENDOR_LIBRARY_NAME=nvidia
        export __VK_LAYER_NV_optimus=NVIDIA_only
        exec "$@"
      '';
  in lib.mkMerge [
    (mkIf cfg.enable {
      environment.systemPackages = [ nvidia-offload ];

      # Load nvidia driver for Xorg and Wayland
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
        powerManagement.finegrained = true;
        open = false;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.production;
        prime = mkIf cfg.prime.enable {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
          inherit (cfg.prime) intelBusId nvidiaBusId;
        };
      };
    })

    (mkIf cfg.disable {
      boot.extraModprobeConfig = ''
        blacklist nouveau
        options nouveau modeset=0
      '';
      boot.blacklistedKernelModules =
        [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
      services.udev.extraRules = ''
        # Remove NVIDIA USB xHCI Host Controller devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA USB Type-C UCSI devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA Audio devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA VGA/3D controller devices
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
      '';
    })
  ];
}
