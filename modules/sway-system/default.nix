{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.sessionPackages = [ pkgs.sway ];
  };

  programs.sway.enable = true;
}

