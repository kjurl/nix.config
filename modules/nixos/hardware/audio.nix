{ lib, pkgs, config, ... }: {
  options.modules.hardware.audio.enable = lib.mkEnableOption "audio";
  config = let
    inherit (lib) mkIf;
    cfg = config.modules.hardware.audio;
    bluetoothCfg = config.modules.hardware.bluetooth;
  in mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      pwvucontrol # Pipewire Volume Control
      bluez # Bluetooth support
      bluez-tools # Bluetooth tools
    ];

    hardware.pulseaudio.enable = false;
    # security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber = mkIf bluetoothCfg.enable {
        enable = true;
        # extraConfig.bluetoothEnhancements = {
        #   "monitor.bluez.properties" = {
        #     "bluez5.enable-sbc-xq" = true;
        #     "bluez5.enable-msbc" = true;
        #     "bluez5.enable-hw-volume" = true;
        #     "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
        #   };
        # };
      };

      # extraConfig.pipewire."92-low-latency" = {
      #   "context.properties" = {
      #     "default.clock.rate" = 44100;
      #     "default.clock.quantum" = 512;
      #     "default.clock.min-quantum" = 512;
      #     "default.clock.max-quantum" = 512;
      #   };
      # };
    };

    boot.extraModprobeConfig = ''
      options snd-hda-intel dmic_detect=0
    '';

    #   services.udev.extraRules = ''
    #     KERNEL=="rtc0", GROUP="audio"
    #     KERNEL=="hpet", GROUP="audio"
    #   '';
    #
    #   security.pam.loginLimits = [
    #     {
    #       domain = "@audio";
    #       item = "memlock";
    #       type = "-";
    #       value = "unlimited";
    #     }
    #     {
    #       domain = "@audio";
    #       item = "rtprio";
    #       type = "-";
    #       value = "99";
    #     }
    #     {
    #       domain = "@audio";
    #       item = "nofile";
    #       type = "soft";
    #       value = "99999";
    #     }
    #     {
    #       domain = "@audio";
    #       item = "nofile";
    #       type = "hard";
    #       value = "524288";
    #     }
    #   ];
  };
}
