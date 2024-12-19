{ lib, ... }: let inherit (lib) utils; in { imports = utils.scanPaths ./.; }
