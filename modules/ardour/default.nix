{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.programs.ardour;
in {
  options.programs.ardour = {
    enable = mkEnableOption "ardour daw";
  };

  config = mkIf cfg.enable {
    #FIXME
    #home.packages = with pkgs; [ ardour ];
  };
}
