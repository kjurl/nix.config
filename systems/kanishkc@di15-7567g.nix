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
    desktop = {
      desktopEnvironment = "gnome";
      wallpaper.default = builtins.fetchurl {
        name = "wallpaper.jpg";
        url =
          "https://getwallpapers.com/wallpaper/full/6/2/2/1244562-beautiful-peaceful-anime-wallpaper-1920x1200-for-lockscreen.jpg";
        sha256 = "sha256:1r0ai23mdl9xyymrdr4rns7rhm4flk9cgpjvz84jpa4id8hz527l";
      };
    };
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
      yazi.enable = true;
      vscodium.enable = true;
      # waybar.enable = true;
      # rofi.enable = true;
    };

    services = {
      flatpak.enable = true;
      # hypridle.enable = true;
      # hyprpaper.enable = true;
      # swaync.enable = true;
    };
    shell = {
      enable = true;
      sillyTools = true;
      fastfetch.enable = true;
    };
  };
}
