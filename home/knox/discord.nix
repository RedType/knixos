{ pkgs, ... }:

{
  home = {
    packages = with pkgs; [ discord ];
    # stop discord from demanding constant updates
    file.".config/discord/settings.json".text = ''
      {
        "SKIP_HOST_UPDATE": true
      }
    '';
  };
}

