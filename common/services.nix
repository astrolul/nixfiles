{ config, pkgs, inputs, ... }:
{

services.blueman.enable = true;

  services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
    "monitor.bluez.properties" = {
      "bluez5.enable-sbc-xq" = true;
      "bluez5.enable-msbc" = true;
      "bluez5.enable-hw-volume" = true;
      "bluez5.roles" = [ "a2dp_sink" "a2dp_source" "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
      "bluez5.codecs" = [ "sbc" "sbc_xq" "aac" "aptx" "aptx_hd" "ldac" ];
    };
  };

  services.pipewire.wireplumber.extraConfig."11-bluetooth-policy" = {
    "wireplumber.settings" = {
      "bluetooth.autoswitch-to-headset-profile" = false;
    };
  };

  services.displayManager.ly.enable = true;
  
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.curl}/bin/curl -L -o /home/astrolul/.cache/wallpaper.png \
      "https://raw.githubusercontent.com/astrolul/dotfiles/refs/heads/x230/wallpapers/wallpapers/wallhaven-1pd22w.png"
    ${pkgs.feh}/bin/feh --bg-fill /home/astrolul/.cache/wallpaper.png &
    slstatus &
  '';

  services.picom = {
    enable = true;
    backend = "xrender";
    vSync = true;
  };

  services.unclutter = {
    enable = true;
    timeout = 3;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.libinput = {
    enable = true;
    touchpad.tapping = false;
  };

  services.openssh.enable = true;

}
