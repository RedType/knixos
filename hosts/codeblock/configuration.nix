{ config, lib, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

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
