{ pkgs, fetchPypi }:
with pkgs.python3Packages;
buildPythonPackage rec {
  format = "pyproject";
  pname = "spotify_to_ytmusic";
  version = "0.5.1";
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-QpC7LSbwVGodHacQCFEZInrA8wNzSMMCQfDsKJkzgzk=";
  };

  propagatedBuildInputs =
    [ setuptools setuptools-scm ytmusicapi spotipy platformdirs ];

}
