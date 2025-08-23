lib: {
  # auto ./. config [] cfg: {  }
  # 1. Options are already taken according to directory.
  # 2. Auto-add an enable option, with the filename str.
  # 3. cfg is auto mapped to correct option value.
  auto = path: config: adder: func:
    let
      findKeys = path:
        let
          prefix = "modules";
          # HACK: to relative path (str)
          pathString = "." + builtins.toString path;
          pathList = lib.path.subpath.components pathString;
          stopIndex =
            lib.lists.findFirstIndex (x: x == "modules") null pathList;
          # drop till modudles/{nixos,home-manager}
          keysList = lib.lists.drop (stopIndex + 2) pathList;
        in [ prefix ] ++ lib.optionals (stopIndex != null) keysList;
      setOptions = keys: value:
        lib.lists.foldl' (acc: key: { ${key} = acc; }) value
        (lib.lists.reverseList keys);
      getConfig = config: keys:
        let set = config; # config is the set
        in builtins.foldl' (currentSet: key: currentSet.${key}) set keys;

      keys = (findKeys path) ++ adder;
      cfg = getConfig config keys;
      ops = {
        options = setOptions keys retval.options;
      };
      retval = func cfg;

    in (removeAttrs retval [ "options" ]) // ops;
}
