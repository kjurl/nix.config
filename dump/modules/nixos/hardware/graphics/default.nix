{ lib, pkgs, config, ... }: {
  imports = lib.x.imports.scanPaths ./.;
  options.modules.hardware.graphics.enable =
    lib.mkEnableOption "graphics functionality";
  config = let cfg = config.modules.hardware.graphics;
  in lib.mkIf cfg.enable {
    nixpkgs.config.packageOverrides = pkgs: {
      intel-vaapi-driver =
        pkgs.intel-vaapi-driver.override { enableHybridCodec = true; };
    };

    # Enable OpenGL
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
        nv-codec-headers-12
        mesa
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver
        intel-vaapi-driver
        vaapiVdpau
        libvdpau-va-gl
        mesa
      ];
    };
  };
}
