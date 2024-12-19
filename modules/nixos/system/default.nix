{ lib, ... }:
let inherit (lib) utils mkEnableOption mkOption types;
in { imports = utils.scanPaths ./.; }
