{ pkgs, ... }:

{
  users.users.knox = {
    isNormalUser = true;
    isSystemUser = false;
    createHome = true;
    extraGroups = [ "audio" "networkmanager" "video" "wheel" ];
    initialHashedPassword =
      "$6$Uy3VXhGKzHAyxwTa$iL2Z7WjGjBHNkDfe1Xhw8zJAdTL90.a.PSzApq1vXIH2Z7aDWSwBcCJx6TnxTzhYHEROQlpfsjI24phkWBJOy0";
  };

  home-manager.users.knox = {
    home.file.".bashrc".source = ./dotfiles/bashrc;

    imports =
      [ ./alacritty
        #./ardour #FIXME
        ./neovim
        #./xmonad
        ./sway
      ];

    home.packages = with pkgs;
      [ ardour #TODO make me a module
        imagemagick
        keepassxc
        neofetch
        nodejs
        rclone
        rustup
        steam
        unzip
        xdotool
        xonotic
        yarn
        zip
      ];
  };
}
