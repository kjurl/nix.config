lib: {
  firefoxSearchEngine = { aliases ? [ "@np" ], params ? [
    "https://search.nixos.org/packages"
    "type:packages"
    "channel:unstable"
    "query:{searchTerms}"
  ], icon ? "" }: {
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
}
