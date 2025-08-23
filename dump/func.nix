let
  pkgs = import <nixpkgs> { };
  lib = pkgs.lib;

  # List nix entries (dirs + nix files, excluding default.nix)
  listNixEntries = path:
    let
      entries = builtins.readDir path;
      filtered = lib.filterAttrs (name: type:
        type == "directory"
        || (name != "default.nix" && lib.hasSuffix ".nix" name)) entries;
      names = lib.attrNames filtered;
    in map (name: path + "/${name}") names;

  flakeInputs = (builtins.getFlake (toString ./.)).inputs;
  path = ./temp;

  # Remove comment lines starting with #
  stripComments = text:
    let
      lines = lib.splitString "\n" text;
      clean = map
        (line: if lib.hasPrefix "#" (lib.strings.trim line) then "" else line)
        lines;
    in lib.concatStringsSep "\n" clean;

  # Extract all input.<something> matches from text
  extractInputs = text:
    let
      rec3 = t:
        let m = builtins.match ".*input\\.([a-zA-Z0-9_-]+).*" t;
        in if m == null then
          [ ]
        else
          [ builtins.elemAt m 0 ] ++ rec3 (lib.concatStringsSep ""
            (lib.tail (lib.splitString (builtins.elemAt m 0) t)));
    in rec3 (stripComments text);

  # Decide whether to keep a file
  shouldKeepFile = filePath:
    let
      fileContents = builtins.readFile filePath;
      contentsNoComments = stripComments fileContents;
      inputs = extractInputs contentsNoComments;
    in if lib.hasInfix "input" contentsNoComments then
      lib.all (i: flakeInputs ? i) inputs
    else
      true;

in lib.filter shouldKeepFile (listNixEntries path)
