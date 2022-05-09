{
  description = "nixos configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    minimalist-source = {
      url = "github:dikiaap/minimalist";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, minimalist-source }:
    let
      specialArgs = {
        inherit minimalist-source;
      };
   
      hm-module = home-manager.nixosModules.home-manager;
   
      hm-settings.home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "bak";
        extraSpecialArgs = specialArgs;
      };
    in {
      nixosConfigurations = {
        baserock = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";
          modules =
            [ ./hosts/baserock/configuration.nix
              ./common/my-locale.nix
              #./modules/sddm
              #./modules/sway-system

              # users
              hm-module
              hm-settings
              ./home/knox
            ];
        };
   
        codeblock = nixpkgs.lib.nixosSystem {
          inherit specialArgs;
          system = "x86_64-linux";
          modules =
            [ ./hosts/codeblock/configuration.nix
              #nixos-hardware.nixosModules.lenovo-thinkpad-x1-extreme-gen2
              ./common/my-locale.nix
              ./modules/sddm
              ./modules/sway-system

              # users
              hm-module
              hm-settings
              ./home/knox
            ];
        };
      };
    };
}

