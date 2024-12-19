{ lib, pkgs, inputs, ... }: {
  # imports = let
  #   collectValues = attrs: acc:
  #     builtins.foldl' (acc': value:
  #       if builtins.isAttrs value then
  #         collectValues value acc'
  #       else
  #         acc' ++ [ value ]) acc (builtins.attrValues attrs);
  # in (collectValues (inputs.haumea.lib.load {
  #   src = ./system;
  #   loader = inputs.haumea.lib.loaders.path;
  # }) [ ]) ++ [ inputs.stylix.nixosModules.stylix ];
  imports = lib.utils.scanPaths ./. ++ [ inputs.sops-nix.nixosModules.sops ];
  config = {
    environment.systemPackages = with pkgs; [
      devenv
      (writeScriptBin "nix-clean" # bash
        ''
          nix-env --delete-generations old
          nix-store --gc
          for link in /nix/var/nix/gcroots/auto/*
          do
            rm $(readlink "$link")
          done
          nix-collect-garbage -d
        '')
    ];

    programs.gamemode.enable = true;
    # services.ratbagd.enable = true;

    # https://github.com/tinted-theming/schemes/tree/spec-0.11/base16

    hardware.uinput.enable = true;
    users.groups.uinput.members = [ "kanishkc" ];
    users.groups.input.members = [ "kanishkc" ];

    # extraGroups = [
    #     "nixosvmtest"
    #     "networkmanager"
    #     "wheel"
    #     "audio"
    #     "video"
    #     "libvirtd"
    #     "docker"
    #   ];
    #
    # make gnome toggelable
    # specialisation = {
    #   gnome.configuration = {
    #     system.nixos.tags = ["Gnome"];
    #     hyprland.enable = lib.mkForce false;
    #     gnome.enable = true;
    #   };
    # };
  };
}
# inputs.haumea.lib.load {
#   src = ./.;
#
#   inputs = { inherit inputs lib; };
#   # loader = inputs.haumea.lib.loaders.scoped lib;
#   transformer = [
#     (inputs.haumea.lib.transformers.hoistAttrs "options" "options")
#     # inputs.haumea.lib.transformers.liftDefault
#   ];
# }
# builtins.toString ./.;
# imports = [
#   lib.evalModules
#   {
#     modules = let
#       isLambda = v: builtins.isFunction v;
#       isAttrs = v: builtins.isAttrs v;
#       getList = set:
#         if isAttrs set then
#           builtins.concatLists (map (v: getList v) (builtins.attrValues set))
#         else if isLambda set then
#           [ set ]
#         else
#           [ ];
#     in getList inputs.haumea.lib.load {
#       src = ./modules/nixos;
#       inputs = args // { inherit inputs; };
#       loader = inputs.haumea.lib.loaders.default lib;
#       transformer = [
#         (inputs.haumea.lib.transformers.hoistAttrs "options" "options")
#         inputs.haumea.lib.transformers.liftDefault
#       ];
#     };
#   }
# ];

