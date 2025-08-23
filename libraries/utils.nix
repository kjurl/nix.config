lib: {
  flakePkgs = args: flake:
    args.inputs.${flake}.packages.${args.options._module.args.value.pkgs.system};
  flakeConfigsEnum = set: prefix:
    # type = with lib.types;
    #   nullOr (enum lib.utils.flakeConfigsEnum inputs "waybar-");
    let
      prefixLen = lib.stringLength prefix;
      isPrefixed = key: lib.hasPrefix prefix key;
      extractKey = key: lib.substring prefixLen (lib.stringLength key) key;
    in map extractKey (lib.filter isPrefixed (lib.attrNames set));
  # a function that takes a theme name and a source file and compiles it to CSS
  # utils.compilsSCSS "theme-name" "path/to/theme.scss" -> "$out/theme-name.css"
  # adapted from <https://github.com/spikespaz/dotfiles>
  compilsSCSS = pkgs:
    { name, source, args ? "-t expanded", }:
    "${
      pkgs.runCommandLocal name { } ''
        mkdir -p $out
        ${lib.getExe pkgs.sassc} ${args} '${source}' > $out/${name}.css
      ''
    }/${name}.css";
}
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
