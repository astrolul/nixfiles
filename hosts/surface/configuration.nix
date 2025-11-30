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

  services.tlp.enable = true;

  qt = {
    enable = true;
    platformTheme = "gtk2";
#    style.name = "gtk2";
  };

  environment.systemPackages = with pkgs; [
    (inputs.st-src.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (oldAttrs: rec {
      configFile = fetchurl {
        url = "https://raw.githubusercontent.com/astrolul/st/main/config.h";
        sha256 = "0g2qrp7hvar9wi981x8pnjfgy2cjiyqc15ggmbqbr8n4m6ihkhsl";
      };
      postPatch = (oldAttrs.postPatch or "") + ''
        cp ${configFile} config.h
        sed -i '/CPPFLAGS =/ s/$/ -DFONT_SIZE=25/' config.mk
      '';
    }))

    (inputs.slstatus-src.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (oldAttrs: rec {
      configFile = fetchurl {
        url = "https://raw.githubusercontent.com/astrolul/slstatus/main/config.h";
        sha256 = "1ard769mmdf8vxj2g0zdyfv3ghfw7s540cdwqks94snlawf37fnl";
      };
      postPatch = (oldAttrs.postPatch or "") + "\n cp ${configFile} config.h";
    }))

    (inputs.dmenu-src.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (oldAttrs: rec {
      configFile = fetchurl {
        url = "https://raw.githubusercontent.com/astrolul/dmenu/main/config.h";
        sha256 = "1j0qsz8lw4vxv57cdmygyj5bix5vn51c4sb3sfg0c72ywr0pyxmv";
      };
      postPatch = (oldAttrs.postPatch or "") + ''
        cp ${configFile} config.h
        sed -i '/CPPFLAGS =/ s/$/ -DFONT_SIZE=14 -DBAR_HEIGHT=9/' config.mk
      '';
    }))

  ];

  services.xserver = {
    enable = true;
    autorun = true;
    dpi = 160;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
        # Use the dwm source from our flake input
        src = inputs.dwm-src;

        # Fetch our custom config.h from a URL (pin with a fixed sha256)
        configFile = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/astrolul/dwm/refs/heads/main/config.h";
          sha256 = "0i7gr68xprn6j9v803v8rkym3bagxda3amp475kfh3794lyq2dxb";
        };

        # In postPatch, copy the fetched config into place before building
        postPatch = (oldAttrs.postPatch or "") + ''
          cp ${configFile} config.h
          sed -i '/CPPFLAGS =/ s/$/ -DFONT_SIZE=14 -DGLYPH_SIZE=22/' config.mk
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
  system.stateVersion = "25.11"; # Did you read the comment?

}
