{ lib, pkgs, config, inputs, username, osConfig, ... }:
let kys = lib.utils.findKys ./. ++ [ "_template_" ];
in {
  imports = [ ];
  options = lib.utils.setOptions kys {
    enable = lib.mkEnableOption "_template_";
    flavour = lib.mkOption {
      type = with lib.types; nullOr (enum [ "" ]);
      default = null;
    };
  };
  config = let cfg = lib.utils.getConfig config kys;
  in lib.mkIf cfg.enable {
    # desktop.hyprland.settings = { exec-once = [ "" ]; };

    # xdg.configFile."_template_".source = let
    #   mkMutableSymlink = path:
    #     config.lib.file.mkOutOfStoreSymlink ("/home/${username}/.nixos-config"
    #       + lib.strings.removePrefix (toString inputs.self) (toString path));
    # in lib.mkIf (cfg.flavour == null) (mkMutableSymlink ../../../config/_template_);

    # home.packages = with pkgs;
    #   [ ] ++ [
    #     wl-clipboard
    #     wf-recorder
    #     supergfxctl
    #     hyprpicker
    #     wayshot
    #     swappy
    #     slurp
    #     fzf
    #   ];

    # programs._template_ = {
    #   enable = true;
    #   configDir = let flv = cfg.flavour;
    #   in if flv == null then
    #     ../../../config/_template_
    #   else
    #     { "" = "${inputs._template_2}/repo/subdir"; }."${cfg.flavour}";
    #   extraPackages = with pkgs;
    #     [ ] ++ lib.optionals (cfg.flavour == null) [ ] ++ {
    #       "" = [
    #         pywal
    #         (python311.withPackages
    #           (p: [ p.material-color-utilities p.pywayland ]))
    #       ];
    #     }."${cfg.flavour}";
    # };
  };
}
