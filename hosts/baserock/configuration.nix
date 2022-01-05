{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      version = 2;
      device = "/dev/sda";
      useOSProber = true;
    };
  };

  users = {
    mutableUsers = false;
    # disable root user
    users."root".hashedPassword = "!";
  };

  environment.systemPackages = with pkgs;
    [ firefox
      git
      pciutils
      vim
      wget
    ];

  services = {
    openssh.enable = true;
    printing.enable = true;
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
  #boot.loader.systemd-boot.memtest86.enable = true;

  networking = {
    hostName = "baserock";
    interfaces.enp5s0.useDHCP = true;
    firewall.allowedTCPPorts =
      [ 25565 # minecraft
        25566 # minecraft (modded)
      ];
    firewall.allowedUDPPorts =
      [ 25565 # minecraft
        25566 # minecraft (modded)
      ];
  };

  services.xserver.enable = true;

  # it's ok if this doesn't match the nixos version
  system.stateVersion = "21.05";
}

