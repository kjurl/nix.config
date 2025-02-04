{ pkgs, inputs, ... }: {
  # home.packages = with pkgs; [ hyprdim hyprnome ];
  # add hyprfreeze, flameshot];
  wayland.windowManager.hyprland = {
    enable = true;
    # ...
    plugins = [
      # inputs.Hyprkool.packages.${pkgs.system}.hyprkool-plugin
      # ...
    ];
  };
}
