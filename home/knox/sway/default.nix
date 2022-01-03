{ pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;
    config = {
      gaps = {
        inner = 5;
        smartGaps = true;
      };
      menu = "${pkgs.wofi}/bin/wofi --show run";
      modifier = "Mod4"; # windows key modifier
      output."*" = {
        bg = "${./background.png} fill";
      };
      startup =
        [ { command = "systemctl --user restart waybar"; always = true; }
        ];
      terminal = "alacritty";
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings =
      [ {
          output = "*";
          layer = "bottom";
          position = "top";
          #modules-left =
          #  [ "sway/workspaces"
          #    "sway/mode"
          #    "sway/window"
          #  ];
          #modules-center = [ "" ];
          #modules-right = [];
          #modules = {
          #};
        }
      ];
  };
}
