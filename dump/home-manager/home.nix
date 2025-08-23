{ config, pkgs, ... }:

{
  imports = [
    ./modules/shell.nix
    ./modules/git.nix
    ./modules/development.nix
    ./modules/packages.nix
  ];

  # Basic home configuration
  home = {
    username = builtins.getEnv "USER";
    homeDirectory = "/home/${builtins.getEnv "USER"}";
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # XDG directories
  xdg = {
    enable = true;
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    cacheHome = "${config.home.homeDirectory}/.cache";
  };

  # Environment variables
  home.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "wslview";
    TERM = "xterm-256color";

    # Development environment variables
    PYTHONDONTWRITEBYTECODE = "1";
    NODE_ENV = "development";

    # WSL-specific
    WSL_DISTRO_NAME = "NixOS";
  };

  # Session path
  home.sessionPath =
    [ "$HOME/.local/bin" "$HOME/.cargo/bin" "$HOME/.npm-global/bin" ];
}
