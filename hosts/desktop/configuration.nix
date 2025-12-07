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
      ../../common/programs.nix
      ../../common/services.nix
    ];

  # Bootloader.

  boot.loader = {
    efi.canTouchEfiVariables = true;  # Required for UEFI
    grub = {
      enable = true;
      efiSupport = true;  # Enable EFI mode
      device = "nodev";  # No device for UEFI (uses EFI partition instead)
      useOSProber = true;  # If dual-booting
      memtest86.enable = true;
      # Optional: Extra GRUB config
      # extraEntries = '' ... '';  # For custom boot entries
    };
    # Optional: EFI mount point if customized
    # efi.efiSysMountPoint = "/boot/efi";
  };

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

#  services.tlp.enable = true;

  qt = {
    enable = true;
    platformTheme = "gtk2";
#    style.name = "gtk2";
  };

  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

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
  system.stateVersion = "25.11"; # Did you read the comment?

}
