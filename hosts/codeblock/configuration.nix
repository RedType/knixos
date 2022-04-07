{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../common/bluetooth.nix
  ];

  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
        editor = false;
        #memtest86.enable = true;
      };
    };
    # use latest kernel for wifi compaitiblity
    kernelPackages = pkgs.linuxPackages_latest;
  };

  users = {
    mutableUsers = false;
    # disable root user
    users."root".hashedPassword = "!";
  };

  environment.systemPackages = with pkgs;
    [ dhcpcd
      firefox
      git
      pciutils
      vim
      wget
    ];

  services = {
    openssh.enable = true;
    printing = {
      enable = true;
      drivers = [ pkgs.hplip ];
    };
  };

  virtualisation.docker.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # enable nix command and flakes
  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
    autoOptimiseStore = true;
  };
  nixpkgs.config.allowUnfree = true;

  networking = {
    hostName = "codeblock";
    networkmanager.enable = true;
    #firewall.allowedTCPPorts =
    #  [ ];
    #firewall.allowedUDPPorts =
    #  [ ];
  };

  services.xserver.enable = true;

  # it's ok if this doesn't match the nixos version
  system.stateVersion = "21.11";
}
