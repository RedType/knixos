{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "ls --color=auto";
    };
  };
}

