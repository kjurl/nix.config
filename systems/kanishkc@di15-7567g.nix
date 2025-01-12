let ok = { enable = true; };
in {
  modules = {
    desktop = { windowManager = "Hyprland"; };

    programs = {
      git-vcs = {
        enable = true;
        userName = "kjurl";
        userEmail = "89933773+kjurl@users.noreply.github.com";
      };
      media.enable = true;
      firefox = {
        enable = true;
        policies.enable = true;
        search.enable = true;
        themes = {
          enable = true;
          name = "gnome-theme";
        };
      };
      neovim.enable = true;
      kitty.enable = true;
      vscodium.enable = true;
      waybar.enable = true;
      # waybar.flavour = "link";
      office.enable = true;
      spotify = ok;
      discord = ok;
    };

    services = {
      hypridle.enable = true;
      hyprpaper.enable = true;
      # kdeconnect.enable = true;
      # swaync.enable = true;
    };
    shell = {
      enable = true;
      sillyTools = true;
      fastfetch.enable = true;
    };
  };
}
