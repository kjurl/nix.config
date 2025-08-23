let yes = { enable = true; };
in {
  modules = {

    core = { homeManager.enable = true; };

    system = { wsl.enable = true; };

  };
}
