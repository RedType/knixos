{
  "bar/top" = {
    fixed.center = true;
    width = "100%";
    height = 22;
    background = [ "#cc000000" "#cc550000" ]; # ARGB colors
    padding = 1; # spaces of padding at each end
    locale = "en_US.UTF-8";
    font = [ "Unifont:style=Sans-Serif" ]; # uses fontconfig patterns
    module.margin = 1;
    modules = {
      left = "title";
      center = "datetime";
      right = "cpu network powermenu";
    };
    tray = {
      position = "right";
      maxsize = 16;
    };
  };

  # my modules

  "module/cpu" = {
    type = "internal/cpu";
    format = "<label> <ramp-coreload>";
    label = "CPU %percentage%%";
    ramp.coreload = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
  };

  "module/datetime" = {
    type = "internal/date";
    date = "%d %b %Y";
    time = "%I:%M:%S %p";
  };

  "module/mem" = {
    type = "internal/memory";
    format = "<label> <ramp-used>";
    label = "Mem: %mb_used%/%mb_free% (%percentage_used%%)";
    ramp.used = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
  };

  "module/network" = {
    type = "internal/network";
    interface = "enp5s0";
    label = {
      connected = "%local_ip%: %downspeed%";
      connected-foreground = "#ff00cc00";
      disconnected = "?.?.?.?: not connected";
      disconnected-foreground = "#ffcc0000";
    };
  };

  "module/powermenu" = {
    type = "custom/menu";
    label = {
      open = "Power";
      close = "x";
      separator = " ";
    };
    menu-0-0 = "Shutdown";
    menu-0-0-exec = "poweroff";
    menu-0-1 = "Reboot";
    menu-0-1-exec = "reboot";
  };

  "module/title" = {
    type = "internal/xwindow";
    label.maxlen = 50;
  };
}
