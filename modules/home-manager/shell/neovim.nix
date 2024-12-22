{ lib, pkgs, config, inputs, ... }: {
  options.modules.programs.neovim.enable = lib.mkEnableOption "neovim";
  config = let
    cfg = config.modules.programs.neovim;
    mkMutableSymlink = path:
      config.lib.file.mkOutOfStoreSymlink (builtins.readFile inputs.root.outPath
        + lib.strings.removePrefix (toString inputs.self) (toString path));
  in lib.mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      # https://github.com/mason-org/mason-registry/tree/main/packages
      # https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      extraPackages = with pkgs; [
        # language-servers
        lua-language-server
        nodePackages.bash-language-server
        nodePackages.yaml-language-server
        nodePackages.vscode-langservers-extracted
        nodePackages.typescript-language-server
        nodePackages.diagnostic-languageserver
        pyright
        basedpyright
        rust-analyzer
        taplo
        nixd

        # refinement
        stylua
        statix
        deadnix
        fixjson
        prettierd
        eslint_d
        mypy
        black
        isort
        nixfmt-classic

        # extras
        wl-clipboard
        ripgrep
        deno
        zig
      ];
      withNodeJs = true;
      withPython3 = true;
    };

    xdg = {
      # configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink
      configFile."nvim".source = mkMutableSymlink ../../../config/nvim;
      # /home/${username}/.nixos-config/config/nvim;
      desktopEntries."nvim" = lib.mkIf pkgs.stdenv.isLinux {
        name = "NeoVim";
        comment = "Edit text files";
        icon = "nvim";
        exec = "kitty --hold nvim %F"; # --hold
        categories = [ "TerminalEmulator" ];
        terminal = false;
        mimeType = [ "text/plain" ];
      };
    };
  };
}
