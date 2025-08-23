lib: rec {
  # Legacy
  scanPaths = path:
    map (f: (path + "/${f}")) (lib.attrNames (lib.filterAttrs (path: _type:
      (_type == "directory")
      || ((path != "default.nix") && (lib.strings.hasSuffix ".nix" path)))
      (builtins.readDir path)));

  # Basic importing from default.nix
  # scanPaths = path: scanPathsIgnore path [ ];

  scanPathsIgnore = path: ignore:
    lib.pipe (builtins.readDir path) [
      # Keep only directories and .nix files (excluding default.nix)
      (lib.filterAttrs (name: type:
        type == "directory"
        || (name != "default.nix" && lib.strings.hasSuffix ".nix" name)))
      lib.attrNames # Extract just the names
      (map (name: path + "/${name}")) # Prepend full path
      (x: !(lib.elem x ignore))
    ];

  # Intelligent importing from default.nix
  scanPathsSafe = path:
    let
      flakeContents = builtins.readFile ./flake.nix;
      # Extract all "input.<something>." occurrences from text
      extractInputs = text:
        let
          recurse = t: acc:
            let m = builtins.match ".*?input\\.([a-zA-Z0-9_-]+)\\.(.*)" t;
            in if m == null then
              acc
            else
              recurse (builtins.elemAt m 1) (acc ++ [ builtins.elemAt m 0 ]);
        in recurse text [ ];
      # Decide whether to keep a file
      shouldKeepFile = filePath:
        let
          fileContents = builtins.readFile filePath;
          firstLine = lib.head (lib.splitString "\n" fileContents);
          inputs = extractInputs fileContents;
        in (!lib.strings.contains "input" firstLine)
        || lib.all (i: lib.strings.contains i flakeContents) inputs;

    in lib.filter shouldKeepFile (scanPaths path);

  # Trying to evaluate the flake for inputs.
  scanPathSafePlus = path:
    let
      flakeInputs = (builtins.getFlake (toString ./.)).inputs;
      # Remove comments (lines starting with #) before scanning
      stripComments = text:
        lib.pipe (lib.splitString "\n" text) [
          (map (line:
            if lib.strings.hasPrefix "#" (lib.strings.trim line) then
              ""
            else
              line))
          (lines: lib.concatStringsSep "\n" lines)
        ];

      # Extract all "input.<something>." occurrences from text
      extractInputs = text:
        let
          recurse = t: acc:
            let m = builtins.match ".*?input\\.([a-zA-Z0-9_-]+)\\.(.*)" t;
            in if m == null then
              acc
            else
              recurse (builtins.elemAt m 1) (acc ++ [ builtins.elemAt m 0 ]);
        in recurse (stripComments text) [ ];

      # Decide whether to keep a file
      shouldKeepFile = filePath:
        let
          fileContents = builtins.readFile filePath;
          firstLine = lib.head (lib.splitString "\n" fileContents);
          inputs = extractInputs fileContents;
        in (!lib.strings.contains "input" firstLine)
        || lib.all (i: flakeInputs ? ${i}) inputs;

    in lib.filter shouldKeepFile (scanPaths path);

}
