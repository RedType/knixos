{ pkgs, ... }:

let
  sddm-slice-theme = builtins.fetchGit {
    url = "https://github.com/radrussianrus/sddm-slice";
    rev = "1ddbc490a500bdd938a797e72a480f535191b45e";
  };
in {
  # for sddm themes
  environment.systemPackages = [ pkgs.libsForQt5.qtgraphicaleffects ];

  services.xserver.displayManager.sddm = {
    enable = true;
    autoNumlock = true;
    settings = {
      Theme = {
        FacesDir = "${./faces}";
        EnableAvatars = true;
        ThemeDir = "${sddm-slice-theme}";
        Current = ".";
      };
    };
  };
}

