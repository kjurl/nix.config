{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;

    # User configuration - these can be overridden by local git config
    userName = builtins.getEnv "GIT_USER_NAME" or "Your Name";
    userEmail = builtins.getEnv "GIT_USER_EMAIL" or "your.email@example.com";

    # Global git configuration
    extraConfig = {
      init.defaultBranch = "main";

      # Core settings
      core = {
        editor = "vim";
        autocrlf = "input";
        safecrlf = true;
        filemode = false; # Important for WSL
      };

      # Push settings
      push = {
        default = "simple";
        followTags = true;
      };

      # Pull settings
      pull.rebase = false;

      # Color settings
      color = {
        ui = true;
        branch = "auto";
        diff = "auto";
        status = "auto";
      };

      # Diff and merge tools
      merge = {
        tool = "vimdiff";
        conflictstyle = "diff3";
      };

      # Credential helper for WSL
      credential.helper = "store";

      # WSL-specific settings
      core.fileMode = false;
      core.symlinks = false;
    };

    # Global gitignore
    ignores = [
      # OS generated files
      ".DS_Store"
      ".DS_Store?"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      "ehthumbs.db"
      "Thumbs.db"

      # Editor files
      "*~"
      "*.swp"
      "*.swo"
      ".vscode/"
      ".idea/"

      # Language specific
      "node_modules/"
      "__pycache__/"
      "*.pyc"
      ".pytest_cache/"
      "*.egg-info/"
      "venv/"
      ".env"

      # Build artifacts
      "dist/"
      "build/"
      "*.log"

      # Nix
      "result"
      "result-*"
    ];

    # Git aliases
    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      df = "diff";
      lg = "log --oneline --graph --all";
      last = "log -1 HEAD";
      unstage = "reset HEAD --";

      # More advanced aliases
      tree =
        "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      cleanup =
        "!git branch --merged | grep -v '\\*\\|master\\|develop\\|main' | xargs -n 1 git branch -d";
    };
  };

  # SSH configuration for Git
  programs.ssh = {
    enable = true;

    # SSH config for common Git hosting services
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_rsa";
      };

      "gitlab.com" = {
        hostname = "gitlab.com";
        user = "git";
        identityFile = "~/.ssh/id_rsa";
      };
    };

    extraConfig = ''
      # WSL-specific SSH settings
      AddKeysToAgent yes
      IdentityAgent /tmp/ssh-agent.sock
    '';
  };

  # GPG configuration for Git signing
  programs.gpg = { enable = true; };

  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "curses";
  };
}
