{ lib, config, inputs, ... }:
let kys = lib.utils.findKys ./. ++ [ "walker" ];
in {
  imports = [ inputs.walker.homeManagerModules.default ];
  options = lib.utils.setOptions kys { enable = lib.mkEnableOption "walker"; };
  config = let cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable {

    # https://github.com/abenz1267/walker
    programs.walker = {
      enable = true;
      runAsService = true;
      config = {
        search.placeholder = "Search";
        ui.fullscreen = true;
        list = { height = 200; };
        websearch.prefix = "?";
        switcher.prefix = "/";
      };
      # style = ''
      #   * {
      #     color: #dcd7ba;
      #   }
      # '';

    };

    nix.settings = {
      substituters =
        [ "https://walker.cachix.org" "https://walker-git.cachix.org" ];
      trusted-public-keys = [
        "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM="
        "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      ];
    };
  };
}
