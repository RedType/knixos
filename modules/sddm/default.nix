{ pkgs, ... }:

{
  environment.systemPackages = with pkgs;
    [ libsForQt5.qtgraphicaleffects # for sddm themes
    ];

  services.xserver.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    settings = {
      Theme = {
        FacesDir = "${./faces}";
        EnableAvatars = true;
        ThemeDir = "${./themes}";
        Current = "sddm-slice-1.5.1";
      };
    };
  };
}

