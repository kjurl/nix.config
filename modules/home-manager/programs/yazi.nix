{ lib, pkgs, config, ... }:
let kys = lib.utils.findKys ./. ++ [ "yazi" ];
in {
  options = lib.utils.setOptions kys { enable = lib.mkEnableOption "yazi"; };
  config = let cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      package = pkgs.unstable.yazi;
      settings = {
        manager.ratio = [ 1 3 4 ];
        preview = {
          cache_dir = "${config.xdg.cacheHome}/yazi";
          max_height = 1200;
          max_width = 800;
        };
      };
    };

    xdg.mimeApps.defaultApplications = {
      # "inode/directory" = "nemo.desktop";
      "inode/mount-point" = "yazi.desktop";
    };

    nix.settings = {
      extra-substituters = [ "https://yazi.cachix.org" ];
      extra-trusted-public-keys =
        [ "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k=" ];
    };
  };
}

