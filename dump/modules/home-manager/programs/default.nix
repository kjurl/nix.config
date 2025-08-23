{ lib, pkgs, config, ... }:
lib.z ./. config [ "core" ] {
  git-features = {
    userName = lib.mkOption { type = lib.types.str; };
    userEmail = lib.mkOption { type = lib.types.str; };
    github = {
      cli-tool.enable = lib.mkEnableOption "github-cli";
      dashboard.enable = lib.mkEnableOption "github-tui";
    };
    changelog-helper.enable = lib.mkEnableOption "git-cliff";
  };
} (cfg: {
  imports = lib.x.imports.scanPaths ./. ++ [ ];
  config.programs = let gitCfg = cfg.git-features;
  in {
    nix-index.enable = true;
    nix-index.enableBashIntegration = true;
    pandoc.enable = false;

    git = {
      enable = true;
      lfs.enable = true;
      delta.enable = true;
      inherit (cfg) userName userEmail;
      aliases = {
        ci = "commit";
        co = "checkout";
        s = "status";
      };
      extraConfig = {
        init.defaultBranch = "main";
        push = { autoSetupRemote = true; };
        credentials.helper = "store";
        credential.helper = "${
            pkgs.git.override { withLibsecret = true; }
          }/bin/git-credential-libsecret";
        color.ui = true;
      };
      ignores = [ "*~" "*.swp" "*result*" "node_modules" ];
    };

    gh.enable = gitCfg.github.cli-tool.enable;
    gh-dash.enable = gitCfg.github.dashboard.enable;
    git-cliff.enable = gitCfg.changelog-helper;

  };

})
