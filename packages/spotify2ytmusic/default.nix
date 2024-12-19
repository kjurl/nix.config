{ pkgs, fetchPypi }:
with pkgs.python3Packages;
buildPythonPackage rec {
  format = "pyproject";
  pname = "spotify2ytmusic";
  version = "0.9.30";
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-uVMIiAe/mflhgyMoP0MLGfk6BV7PXZ5xhIgnprdO4VI=";
  };
  propagatedBuildInputs = [ poetry-core ytmusicapi ];

}
