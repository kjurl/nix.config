{ lib, pkgs, config, ... }:
lib.x.options.auto ./. config [ "bash" ] (cfg: {
  options.enable = lib.mkEnableOption "bash";
  config = lib.mkIf cfg.enable {
    programs.bash = {
      enable = true;
      historyControl = [ "erasedups" "ignorespace" ];
      historyIgnore = [ "ls" "cd" "nh" "exit" ];
      shellOptions = [
        "autocd"
        "cdspell"
        "cmdhist"
        "dotglob"
        "histappend"
        "expand_aliases"
      ];

      initExtra =
        # bash
        ''
          bind "set completion-ignore-case on"

          set -o vi
          bind -m vi-command 'Control-l: clear-screen'
          bind -m vi-insert 'Control-l: clear-screen'
          bind -m vi-insert 'Control-k: previous-history'
          bind -m vi-insert 'Control-j: next-history'

          if [ "$PWD" = "$HOME" ]; then fastfetch; fi
        '';

      shellAliases = {
        cat = "${lib.getExe pkgs.bat}";
        grep = "${lib.getExe pkgs.ripgrep}";
        rm = "trash-put";
      };

    };

    # https://github.com/nix-community/home-manager/pull/3238
    # programs.blesh = {
    #   enable = true;
    #   options = {
    #     prompt_ps1_transient = "trim:same-dir";
    #     prompt_ps1_final="$(${pkgs.starship}/bin/starship module character)";
    #     prompt_rps1_final="$(${pkgs.starship}/bin/starship module time)";
    #     prompt_ruler = "empty-line";
    #   };
    # };
  };
})
