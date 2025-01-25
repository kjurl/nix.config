{
  main = {
    password = "nixos";
    groups = [
      "audio"
      "docker"
      "libvirtd"
      "networkmanager"
      "nixosvmtest"
      "video"
      "wheel"
    ];
  };
  modules = {
    desktop = { desktopEnvironment = "gnome"; };
    programs = {
      discord.enable = true;
      firefox.enable = true;
      firefox.theme = "modblur-theme";
      git-vcs = {
        enable = true;
        userName = "kjurl";
        userEmail = "89933773+kjurl@users.noreply.github.com";
      };
      kitty.enable = true;
      media.enable = true;
      neovim.enable = true;
      office.enable = true;
      spotify.enable = true;
      vscodium.enable = true;
      waybar.enable = true;
      rofi.enable = true;
    };

    services = {
      hypridle.enable = true;
      hyprpaper.enable = true;
      swaync.enable = true;
    };
    shell = {
      enable = true;
      sillyTools = true;
      fastfetch.enable = true;
    };
  };
}
