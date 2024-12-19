{ pkgs, inputs, ... }: {
  imports = [ inputs.Hyprlux.homeManagerModules.default ];
  home.packages = with pkgs; [ hyprdim hyprnome ];
  # add hyprfreeze, flameshot];
  programs.hyprlux = {
    enable = true;

    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };

    night_light = {
      enabled = true;
      # Manual sunset and sunrise
      start_time = "22:00";
      end_time = "06:00";
      # Automatic sunset and sunrise
      latitude = 46.056946;
      longitude = 14.505751;
      temperature = 3500;
    };

    vibrance_configs = [
      {
        window_class = "steam_app_1172470";
        window_title = "Apex Legends";
        strength = 100;
      }
      {
        window_class = "cs2";
        window_title = "";
        strength = 100;
      }
    ];
  };
  wayland.windowManager.hyprland = {
    enable = true;
    # ...
    plugins = [
      # inputs.Hyprkool.packages.${pkgs.system}.hyprkool-plugin
      # ...
    ];
  };
}
