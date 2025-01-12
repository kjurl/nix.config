{ lib, pkgs, config, ... }:
let kys = lib.utils.findKys ./. ++ [ "git-vcs" ];
in {
  options = lib.utils.setOptions kys {
    enable = lib.mkEnableOption "git";
    userEmail = lib.mkOption { type = lib.types.str; };
    userName = lib.mkOption { type = lib.types.str; };
  };
  config = let cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable {
    programs.git = {
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

    programs = {
      gh.enable = true;
      gh-dash.enable = true;
      git-cliff.enable = false;
      # git-credentials-oauth.enable = false;
    };
  };
}
