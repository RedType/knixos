{
  hardware.bluetooth = {
    enable = true;
    extraConfig = ''
      [General]
      ControllerMode = bredr
    '';
  };
  services.blueman.enable = true;
}
