lib:
let inherit (lib) attrNames filterAttrs;
in {
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
        pathString =
          # HACK: convert absolute to relative
          "." + builtins.toString path; # returns an absolute path string
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
