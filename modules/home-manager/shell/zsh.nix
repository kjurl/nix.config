{ lib, pkgs, config, ... }: {
  options.modules.shell.zsh.enable = lib.mkEnableOption "zsh";
  config = lib.mkIf config.modules.shell.zsh.enable {
    programs.zsh = {
      enable = true;
      defaultKeymap = "viins";
      dotDir = ".config/zsh";
      enableCompletion = true;
      syntaxHighlighting.enable = true;

      history = {
        ignoreSpace = true;
        path = "${config.xdg.cacheHome}/zsh/history";
      };

      localVariables = {
        VI_MODE_RESET_PROMPT_ON_MODE_CHANGE = true;
        VI_MODE_SET_CURSOR = true;
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

