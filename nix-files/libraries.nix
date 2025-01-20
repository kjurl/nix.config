lib:
let inherit (lib) attrNames filterAttrs;
in {

  # "Nix Packages" = engine {
  #   aliases = [ "@np" ];
  #   params = [
  #     "https://search.nixos.org/packages"
  #     "type:packages"
  #     "channel:unstable"
  #     "query:{searchTerms}"
  #   ];
  # };
  # "Nix Packages Versions" = engine {
  #   aliases = [ "@npv" ];
  #   params = [
  #     "https://lazamar.co.uk/nix-versions/"
  #     "channel:nixpkgs-unstable"
  #     "package:{searchTerms}"
  #   ];
  # };
  # "Home-manager Options" = engine {
  #   aliases = [ "@hm" ];
  #   params = [
  #     "https://home-manager-options.extranix.com"
  #     "release:master"
  #     "query:{searchTerms}"
  #   ];
  # };
  # "Perplexity" = engine {
  #   aliases = [ "@px" ];
  #   params = [ "https://www.perplexity.ai" "q:{searchTerms}" ];
  # };
  firefox = {
    searchEngine = { aliases ? [ ], params ? [ ], icon ? "" }: {
      definedAliases = aliases;
      urls = let
        splitToSublistsAcc = acc: key:
          if lib.strings.hasInfix "://" key then
            acc ++ [ [ key ] ]
          else
            lib.pipe key [
              (y: (lib.lists.last acc) ++ [ y ])
              (y: (lib.lists.init acc) ++ [ y ])
            ];

        stringToAttrset = str:
          let parts = lib.strings.splitString ":" str;
          in if builtins.length parts == 2 then
            let psElem = builtins.elemAt parts;
            in {
              name = psElem 0;
              value = psElem 1;
            }
          else
            null;

        subLists = lib.lists.foldl splitToSublistsAcc [ ] params;
        final = map (sublist: {
          template = lib.lists.take 1 sublist;
          params = map stringToAttrset (lib.lists.drop 1 sublist);
        }) subLists;

      in lib.attrsets.filterAttrs (e: e != null) final;

      inherit icon;
    };
  };
  utils = {
    # We use an unorthodox pkgs reference here because pkgs will not be in the
    # first layer of arguments if it is not explicitly added to the module
    # parameters. This is annoying because the LSP complains about pkgs being an
    # unused argument when it actually is used. This method avoids that.
    flakePkgs = args: flake:
      args.inputs.${flake}.packages.${args.options._module.args.value.pkgs.system};

    # Get list of all nix files and directories in path for easy importing
    scanPaths = path:
      map (f: (path + "/${f}")) (attrNames (filterAttrs (path: _type:
        (_type == "directory")
        || ((path != "default.nix") && (lib.strings.hasSuffix ".nix" path)))
        (builtins.readDir path)));

    flakeConfigsEnum = set: prefix:
      # type = with lib.types;
      #   nullOr (enum lib.utils.flakeConfigsEnum inputs "waybar-");
      let
        prefixLen = lib.stringLength prefix;
        isPrefixed = key: lib.hasPrefix prefix key;
        extractKey = key: lib.substring prefixLen (lib.stringLength key) key;
      in map extractKey (lib.filter isPrefixed (lib.attrNames set));

    getConfig = config: keys:
      let set = config; # config is the set
      in builtins.foldl' (currentSet: key: currentSet.${key}) set keys;

    setOptions = keys: value:
      lib.lists.foldl' (acc: key: { ${key} = acc; }) value
      (lib.lists.reverseList keys);

    # Get list of all values from set attrs that contain prefix with prefix removed
    findKys = path:
      let
        prefix = "modules";
        # HACK: to relative path (str)
        pathString = "." + builtins.toString path;
        pathList = lib.path.subpath.components pathString;
        stopIndex = lib.lists.findFirstIndex (x: x == "modules") null pathList;
        # drop till modudles/{nixos,home-manager}
        keysList = lib.lists.drop (stopIndex + 2) pathList;
      in [ prefix ] ++ lib.optionals (stopIndex != null) keysList;

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
  };
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
