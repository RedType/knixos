{ pkgs, ... }:

{
  users.users.knox = {
    createHome = true;
    extraGroups = [ "audio" "networkmanager" "video" "wheel" ];
    hashedPassword =
      "$6$Uy3VXhGKzHAyxwTa$iL2Z7WjGjBHNkDfe1Xhw8zJAdTL90.a.PSzApq1vXIH2Z7aDWSwBcCJx6TnxTzhYHEROQlpfsjI24phkWBJOy0";
    isNormalUser = true;
    isSystemUser = false;
    shell = "${pkgs.zsh}/bin/zsh";
  };

  home-manager.users.knox = {
    imports =
      [ ./alacritty
        ./neovim.nix
        ./sway
        ./zsh.nix
      ];

    home = {
      packages = with pkgs;
        [ imagemagick
          keepassxc
          neofetch
          nodejs
          rclone
          rustup
          steam
          unzip
          wl-clipboard
          xdotool
          xonotic
          yarn
          zip
        ];

      sessionVariables = {
        EDITOR = "${pkgs.neovim}/bin/nvim";
        GRIM_DEFAULT_DIR = "$HOME/Screenshots";
        PROMPT = "%B%F{43}%~/%f%b %# ";
      };
    };
  };
}

