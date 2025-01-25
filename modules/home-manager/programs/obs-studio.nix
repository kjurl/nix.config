{ pkgs, ... }: {
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      droidcam-obs
      looking-glass-obs
      obs-backgroundremoval
      obs-move-transition
      obs-multi-rtmp
      obs-pipewire-audio-capture
      wlrobs
    ];
  };
}
