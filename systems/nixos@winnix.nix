{
  main = {
    password = "nixos";
    groups = [ "networkmanager" "libvirtd" "docker" "wheel" ];
  };
  modules = {
    programs = {
      core.git-features = {
        # enable = true;
        userName = "kjurl";
        userEmail = "89933773+kjurl@users.noreply.github.com";
        github.dashboard.enable = true;
        changelog-helper.enable = true;
      };
      # neovim.enable = true;
      # yazi.enable = true;
    };

    shell = {
      # enable = true;
      sillyTools = true;
      fastfetch.enable = true;
      zsh.enable = true;
    };
  };
}
