{
  programs.alacritty = {
    enable = true;
    settings.import = [ "${./config.yml}" ];
  };
}
