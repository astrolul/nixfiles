# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../common/users.nix 
      ../../common/system.nix
      ../../common/services.nix
      ../../common/programs.nix
      ../../common/packages.nix 
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.kernelParams = [ "iomem=relaxed" ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;
  
  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

  services.xserver = {
    enable = true;
    autorun = true;
    dpi = 100;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
        # Use the dwm source from our flake input
        src = inputs.dwm-src;

        # Fetch our custom config.h from a URL (pin with a fixed sha256)
        configFile = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/astrolul/dwm/refs/heads/main/config.h";
          sha256 = "09q67lla37hd7157xn6b627pcfk0likgi8jyl2la6drdj6j7zfns";
        };

        # In postPatch, copy the fetched config into place before building
        postPatch = (oldAttrs.postPatch or "") + ''
          cp ${configFile} config.h
        '';

        # Preserve the required build inputs for dwm
        buildInputs = with pkgs; [
          xorg.libX11
          xorg.libXft
          xorg.libXinerama
          imlib2
          freetype
          harfbuzz
          fontconfig
        ];
     });
   };  
};

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
