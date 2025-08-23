{ lib, pkgs, config, ... }: {
  options.modules.shell.zsh.enable = lib.mkEnableOption "zsh";
  config = lib.mkIf config.modules.shell.zsh.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      defaultKeymap = "viins";

      enableCompletion = true;
      enableAutosuggestions = true;
      syntaxHighlighting.enable = true;

      history = {
        size = 10000;
        ignoreSpace = true;
        path = "${config.xdg.cacheHome}/zsh/history";
      };

      localVariables = {
        VI_MODE_RESET_PROMPT_ON_MODE_CHANGE = true;
        VI_MODE_SET_CURSOR = true;
      };

      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "docker"
          "node"
          "npm"
          "python"
          "rust"
          "golang"
          "kubectl"
          "terraform"
        ];
      };

      completionInit = ''
        autoload -U compinit && compinit
        zstyle ':completion:*' menu select
        zmodload zsh/complist
        compinit
        _comp_options+=(globdots)  # Include hidden files.
        unsetopt completealiases   # Include aliases.
      '';

      initExtra = ''
        source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
        source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

        if [ "$TMUX" = "" ]; then
          exec tmux a
        fi
      '';
    };

  };
}

