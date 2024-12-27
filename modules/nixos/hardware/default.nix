{ lib, pkgs, config, ... }: {
  imports = lib.utils.scanPaths ./.;
  options.modules.hardware = { power.enable = lib.mkEnableOption "power"; };
  config = let
    inherit (lib) mkIf;
    powerCfg = config.modules.hardware.power;
  in {
    services = mkIf powerCfg.enable {
      power-profiles-daemon.enable = true;
      libinput.enable = true;
      upower.enable = true;
    };

    environment.systemPackages = with pkgs; [ policycoreutils ];
    systemd.package = pkgs.systemd.override { withSelinux = true; };
    boot = {
      kernelPackages = pkgs.linuxKernel.packages.linux_zen;
      tmp.cleanOnBoot = true;
      supportedFilesystems = [ "ntfs" ];
      initrd = {
        enable = true;
        systemd.enable = true;

      };
      loader = {
        efi.canTouchEfiVariables = true;
        systemd-boot.enable = true;
        # https://github.com/TLATER/dotfiles/blob/444a85b014ad86dc5a9fa9e5e38c585dcb7958f7/nixos-config/default.nix#L81
        systemd-boot.configurationLimit = 5;
        timeout = 0;
      };
      plymouth = {
        enable = false;
        theme = "liquid";
        themePackages = with pkgs;
          [
            (adi1090x-plymouth-themes.override {
              selected_themes = [ "liquid" ];
            })
          ];
        extraConfig = ''
          nixos_image = Image("${
            toString ../../../.github/assets/nixos-logo.png
          }");
          nixos_sprite = Sprite();
          nixos_sprite.SetImage(nixos_image);

          nixos_sprite.SetX(Window.GetX() + (Window.GetWidth() / 2 - nixos_image.GetWidth() / 2));
          nixos_sprite.SetY(Window.GetY() + (Window.GetHeight() / 2 - nixos_image.GetHeight() / 2));
        '';
      };
      kernelParams = lib.lists.unique ([
        "quiet"
        "splash"
        "fbcon=nodefer"
        "vt.global_cursor_default=0"
        "kernel.modules_disabled=1"
        "lsm=landlock,lockdown,yama,integrity,apparmor,bpf,tomoyo,selinux"
        "boot.shell_on_fail"
        "loglevel=3"
        "usbcore.autosuspend=-1"
        "video4linux"
      ] ++ [
        # Enable "Silent Boot"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
        "nowatchdog"
      ]);
      consoleLogLevel = 0;
      initrd.verbose = false;
    };
    zramSwap.enable = true;
  };
}
