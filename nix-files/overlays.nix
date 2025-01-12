{ inputs, ... }:
_final: prev:
with inputs.stable.legacyPackages.${prev.system}; {
  inherit libsemanage bottles;
  # python312Packages.patool = python312Packages.patool;
}

