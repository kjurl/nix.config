{ config, pkgs, ... }:

{
  # Essential packages for WSL development environment
  home.packages = with pkgs; [
    # System utilities
    coreutils
    findutils
    gnused
    gnugrep
    gawk
    which
    file
    lsof
    psmisc
    procps

    # Archive and compression
    gzip
    bzip2
    xz
    zip
    unzip
    p7zip

    # Network utilities
    openssh
    rsync
    nmap
    netcat-gnu
    socat

    # File management
    tree
    exa
    bat
    ripgrep
    fd
    fzf
    ranger

    # Text processing
    jq
    yq-go
    xmlstarlet

    # System monitoring
    htop
    iotop
    iftop
    ncdu

    # Development tools
    git
    gh
    gitlab-cli
    tig

    # Build tools
    gnumake
    cmake
    autoconf
    automake
    libtool
    pkg-config

    # Compilers and interpreters
    gcc
    clang
    nodejs
    python3
    python3Packages.pip
    python3Packages.virtualenv
    python3Packages.poetry
    go
    rustc
    cargo

    # Database tools
    sqlite
    postgresql
    redis

    # Container and cloud tools
    docker-compose
    kubectl
    terraform
    awscli2

    # Security tools
    gnupg
    openssl

    # Multimedia (basic)
    ffmpeg
    imagemagick

    # Documentation
    man-pages
    tldr

    # Terminal enhancements
    tmux
    screen
    zellij

    # Editors
    vim
    neovim
    nano

    # Shell enhancements
    starship
    zoxide
    direnv

    # Nix tools
    nix-direnv
    nixpkgs-fmt
    nil
    statix

  ];

  # Fonts for terminal (if needed)
  fonts.fontconfig.enable = true;

  # Enable man pages
  programs.man.enable = true;

  # Enable command-not-found
  programs.command-not-found.enable = true;
}
