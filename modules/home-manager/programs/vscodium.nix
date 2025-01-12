# https://nixos.wiki/wiki/VSCodium
{ lib, pkgs, config, ... }: {
  options.modules.programs.vscodium.enable = lib.mkEnableOption "vscodium";
  config = let cfg = config.modules.programs.vscodium;
  in lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      enableUpdateCheck = false;
      mutableExtensionsDir = false;
      enableExtensionUpdateCheck = false;

      # https://marketplace.visualstudio.com/VSCode
      extensions = with pkgs.vscode-extensions; [
        asvetliakov.vscode-neovim
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        charliermarsh.ruff
        christian-kohler.path-intellisense
        github.vscode-github-actions
        github.vscode-pull-request-github
        humao.rest-client
        jnoortheen.nix-ide
        marp-team.marp-vscode
        mkhl.direnv
        ms-python.debugpy
        ms-python.python
        ms-python.vscode-pylance
        ms-toolsai.jupyter
        ms-toolsai.jupyter
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        timonwong.shellcheck
        usernamehw.errorlens
        visualstudioexptteam.vscodeintellicode
        yzhang.markdown-all-in-one
      ];
      userSettings = {
        "editor.codeActionsOnSave" = {
          # "source.fixAll.ruff" = true;
          # "source.organizeImports.ruff" = true;
          "source.sortMembers" = "explicit";
        };
        "editor.detectIndentation" = false;
        "editor.formatOnSave" = true;
        "editor.formatOnSaveMode" = "file";
        "editor.insertSpaces" = true;
        "editor.tabSize" = 2;
        "files.exclude" = {
          "**/.git" = true;
          "**/.svn" = true;
          "**/.hg" = true;
          "**/CVS" = true;
          "**/.DS_Store" = true;
          "**/Thumbs.db" = true;
          "**/node_modules" = true;
          "*.egg-info" = true;
          "**/__pycache__" = true;
          "**/.mypy_cache" = true;
          "**/.pytest_cache" = true;
          "**/.coverage" = true;
          "**/.venv" = true;
        };
        "files.associations" = { ".env.local" = "env"; };
        "material-icon-theme.files.associations" = {
          "tsconfig.alter.json" = "tsconfig";
        };
        "python.terminal.activateEnvironment" = false;
        "python.formatting.provider" = "yapf";
        "python.formatting.yapfArgs" = [ "-i" "-v" ];
        "python.linting.enabled" = true;
        "python.linting.flake8Enabled" = true;
        "python.linting.mypyEnabled" = true;
        "python.linting.banditEnabled" = true;
        "python.testing.pytestEnabled" = true;
        "python.analysis.typeCheckingMode" = "basic";
        "nix.formatterPath" = [ "nix" "fmt" "--" "--" ];
        "workbench.colorTheme" = lib.mkDefault "Catppuccin Mocha";
        "workbench.iconTheme" = "catppuccin-mocha";
        "catppuccin-icons.hidesExplorerArrows" = true;
        "catppuccin.accentColor" = "maroon";
        "catppuccin.bracketMode" = "dimmed";
        "explorer.confirmDelete" = false;
        "explorer.fileNesting.patterns" = {
          "*.ts" = "$\${capture}.js";
          "*.js" = "\${capture}.js.map, \${capture}.min.js, \${capture}.d.ts";
          "*.jsx" = "\${capture}.js";
          "*.tsx" = "\${capture}.ts";
          "tsconfig.json" = "tsconfig.*.json";
          "package.json" =
            "package-lock.json, yarn.lock, pnpm-lock.yaml, bun.lockb";
          "flake.nix" = "flake.lock, flake.nix";
          "devenv.nix" = "devenv.yaml, flake.nix, flake.lock";
        };
      };
    };
  };
}
