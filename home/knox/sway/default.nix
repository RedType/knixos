{ pkgs, ... }:

{
  wayland.windowManager.sway = let
    alacritty     = "${pkgs.alacritty}/bin/alacritty";
    amixer        = "${pkgs.alsa-utils}/bin/amixer";
    brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
    date          = "${pkgs.coreutils}/bin/date";
    grim          = "${pkgs.grim}/bin/grim";
    slurp         = "${pkgs.slurp}/bin/slurp";
    swayidle      = "${pkgs.swayidle}/bin/swayidle";
    swaylock      = "${pkgs.swaylock}/bin/swaylock";
    swaymsg       = "${pkgs.sway}/bin/swaymsg";
    swaynag       = "${pkgs.sway}/bin/swaynag";
    systemctl     = "${pkgs.systemd}/bin/systemctl";
    tee           = "${pkgs.coreutils}/bin/tee";
    wl-copy       = "${pkgs.wl-clipboard}/bin/wl-copy";
    wl-paste      = "${pkgs.wl-clipboard}/bin/wl-paste";
    wofi          = "${pkgs.wofi}/bin/wofi";
  in {
    enable = true;
    systemdIntegration = true;

    config = let
      left  = "h";
      down  = "j";
      up    = "k";
      right = "l";
      menu = ''
        ${wofi} \
        --conf=${./wofi.conf} \
        --style=${./wofi.css}
      '';
      modifier = "Mod4";
      terminal = alacritty;
    in {
      inherit left down up right menu modifier terminal;

      gaps = {
        inner = 5;
        smartGaps = true;
      };
      output."*" = {
        bg = "${./background.png} fill";
      };

      keybindings = {
        # names captured via `nixpkgs#wev`
        XF86MonBrightnessDown   = "exec ${brightnessctl} set 2%-";
        XF86MonBrightnessUp     = "exec ${brightnessctl} set 2%+";
        XF86AudioMute           = "exec ${amixer} sset 'Master',0 toggle";
        XF86AudioLowerVolume    = "exec ${amixer} sset 'Master',0 2%-";
        XF86AudioRaiseVolume    = "exec ${amixer} sset 'Master',0 2%+";
        XF86AudioMicMute        = "exec ${amixer} sset 'Capture',0 toggle";
        Print                   = ''
          exec ${grim} - | \
          ${tee} "$GRIM_DEFAULT_DIR/$(${date} +%Y-%m-%d-%H:%M:%S).png" | \
          ${wl-copy}
        '';
        XF86SelectiveScreenshot = ''
          exec ${grim} -g $(${slurp} -d) - | \
          ${tee} "$GRIM_DEFAULT_DIR/$(${date} +%Y-%m-%d-%H:%M:%S).png" | \
          ${wl-copy}
        '';
        #XF86Display # fn-f7
        #XF86WLAN # fn-f8
        #XF86NotificationCenter # fn-f9
        #XF86PickupPhone # fn-f10
        #XF86HangupPhone # fn-f11
        #XF86Favorites # fn-f12

        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Shift+q" = "kill";
        "${modifier}+d" = "exec ${menu}";

        "${modifier}+${left}"  = "focus left";
        "${modifier}+Left"     = "focus left";
        "${modifier}+${down}"  = "focus down";
        "${modifier}+Down"     = "focus down";
        "${modifier}+${up}"    = "focus up";
        "${modifier}+Up"       = "focus up";
        "${modifier}+${right}" = "focus right";
        "${modifier}+Right"    = "focus right";

        "${modifier}+Shift+${left}"  = "move left";
        "${modifier}+Shift+Left"     = "move left";
        "${modifier}+Shift+${down}"  = "move down";
        "${modifier}+Shift+Down"     = "move down";
        "${modifier}+Shift+${up}"    = "move up";
        "${modifier}+Shift+Up"       = "move up";
        "${modifier}+Shift+${right}" = "move right";
        "${modifier}+Shift+Right"    = "move right";

        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+f" = "fullscreen toggle";

        "${modifier}+space" = "focus mode_toggle";
        "${modifier}+Shift+space" = "floating toggle";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";

        "${modifier}+minus" = "scratchpad show";
        "${modifier}+Shift+minus" = "move scratchpad";

        "${modifier}+Shift+e" = "exec ${swaynag} -t warning -m 'Log out?' -b 'Yes' '${swaymsg} exit'";

        "${modifier}+r" = "mode resize";
      };

      startup =
        [ { command = "${systemctl} --user restart waybar"; always = true; }
          {
            command = ''
              ${swayidle} -w \
                timeout 1800 '${swaymsg} "output * dpms off"' \
                resume       '${swaymsg} "output * dpms on"' \
                timeout 3600 '${swaylock} -f -c 000000' \
                before-sleep '${swaylock} -f -c 000000'
            '';
            always = false;
          }
        ];
    };

    extraConfig = ''
      for_window [app_id="^.*"] inhibit_idle fullscreen
      for_window [class="^.*"]  inhibit_idle fullscreen
    '';
  };

  programs = {
    mako.enable = true;

    waybar = {
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
  };
}
