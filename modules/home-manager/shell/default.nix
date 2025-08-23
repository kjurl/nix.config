{ lib, pkgs, config, ... }:
lib.x.options.auto ./. config [ ] (cfg: {
  imports = lib.x.imports.scanPaths ./.;
  options = {
    sillyTools = lib.mkEnableOption "installation of silly shell tools";
    fastfetch.enable = lib.mkEnableOption "fastfetch";
  };
  config = {
    home = {
      packages = (with pkgs; [ curl btop wget fd killall unrar unzip zip ])
        ++ lib.optionals cfg.sillyTools (with pkgs; [ cbonsai cmatrix cowsay ]);
      sessionVariables = {
        COLORTERM = "truecolor";
        # for eza, ls, tree and many others
        LS_COLORS = "$(${lib.getExe pkgs.vivid} generate catppuccin-mocha)";
      };

      # programs = {
        # bash.shellAliases = {
        #   l = "ll";
        #   ls = "eza";
        #   ll = "eza -l";
        #   lll = "ll -snew --group-directories-first";
        #   la = "eza -la";
        #   laa = "la -snew --group-directories-first";
        # };

        # eza = {
        #   enable = true;
        #   git = true;
        #   icons = "auto";
        #   # enableBashIntegration = false;
        # };
        # fzf = let
        #   fd = lib.getExe pkgs.fd;
        #   bat = lib.getExe pkgs.bat;
        # in {
        #   enable = true;
        #   defaultCommand = "${fd} -H --type f";
        #   changeDirWidgetCommand = "${fd} --type d --hidden --exclude .git";
        #   changeDirWidgetOptions = [ ];
        #   fileWidgetCommand =
        #     "${fd} --type f --hidden --exclude .git --exclude .cache";
        #   fileWidgetOptions = [
        #     "--preview '${bat} --style=numbers --color=always --line-range :500 {}'"
        #   ];

        #   defaultOptions = [
        #     "--height 20%"
        #     "--bind ctrl-p:preview-up,ctrl-n:preview-down,ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down"
        #     "--border rounded"
        #   ];
        #   # Managed by stylix
        #   colors = lib.mkDefault {
        #     bg = "#1e1e2e";
        #     "bg+" = "#313244";
        #     fg = "#cdd6f4";
        #     "fg+" = "#cdd6f4";
        #     hl = "#f38ba8";
        #     "hl+" = "#f38ba8";
        #     spinner = "#f5e0dc";
        #     header = "#f38ba8";
        #     info = "#cba6f7";
        #     pointer = "#f5e0dc";
        #     marker = "#b4befe";
        #     prompt = "#cba6f7";
        #     selectedBg = "#45475a";
        #     # multi = true;
        #   };
        # };
      # };

    };
  };
})
