{ pkgs, ... }:

{
  users.users.knox = {
    createHome = true;
    extraGroups = [ "audio" "docker" "networkmanager" "video" "wheel" ];
    hashedPassword =
      "$6$Uy3VXhGKzHAyxwTa$iL2Z7WjGjBHNkDfe1Xhw8zJAdTL90.a.PSzApq1vXIH2Z7aDWSwBcCJx6TnxTzhYHEROQlpfsjI24phkWBJOy0";
    isNormalUser = true;
    isSystemUser = false;
    shell = "${pkgs.zsh}/bin/zsh";
  };

  home-manager.users.knox = {
    imports =
      [ ./alacritty
        ./discord.nix
        ./neovim.nix
        ./sway
        ./zsh.nix
      ];

    home = {
      file."bin".source = ./bin;

      packages = with pkgs;
        [ awscli2 # bin/awslocal depends on this
          chromium
          docker-compose
          file
          filezilla
          google-cloud-sdk
          imagemagick
          jq
          keepassxc
          neofetch
          nodejs
          (python3.withPackages (p: with p; [
            boto3 # aws sdk for python
            faker
          ]))
          rclone
          slack
          steam
          unzip
          wl-clipboard
          xdotool
          #xonotic
          yarn
          zip
        ];

      sessionPath = [ "$HOME/bin" ];

      sessionVariables = {
        EDITOR = "${pkgs.neovim}/bin/nvim";
        GRIM_DEFAULT_DIR = "$HOME/Screenshots";
        PROMPT = "%B%F{43}%~/%f%b %# ";
      };
    };
  };
}

