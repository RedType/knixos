{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    displayManager.sessionPackages = [ pkgs.sway ];
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
  };

  programs.sway.enable = true;
}

