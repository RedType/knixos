{ pkgs, ... }:

{
  users.users.knox = {
    isNormalUser = true;
    isSystemUser = false;
    createHome = true;
    extraGroups = [ "audio" "networkmanager" "video" "wheel" ];
    hashedPassword =
      "$6$Uy3VXhGKzHAyxwTa$iL2Z7WjGjBHNkDfe1Xhw8zJAdTL90.a.PSzApq1vXIH2Z7aDWSwBcCJx6TnxTzhYHEROQlpfsjI24phkWBJOy0";
  };

  home-manager.users.knox = {
    imports =
      [ ./alacritty
        ./bash.nix
        ./direnv.nix
        ./neovim.nix
        ./sway
      ];

    home.packages = with pkgs;
      [ imagemagick
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

