{ pkgs, ... }:

{
  # dependencies for configs and such
  home.packages = with pkgs;
    [ feh          # set bg image
      scrot        # take screenshots
      xscreensaver # screensavers
    ];

  # compositor for transparency
  services.picom.enable = true;

  #status bar & system tray
  services.polybar = {
    enable = true;
    settings = import ./polybar-settings.nix;
    script = "polybar top &";
  };

  # dmenu but different
  programs.rofi = {
    enable = true;
    terminal = "${pkgs.alacritty}/bin/alacritty";
  };

  xsession = {
    enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hp:
        [ hp.dbus
          hp.monad-logger
          hp.xmonad-contrib
        ];
      config = ./config.hs;
    };

    initExtra = with pkgs; ''
      ${feh}/bin/feh --no-fehbg --bg-scale --randomize ${./backgrounds}/* &
    '';
  };
}
