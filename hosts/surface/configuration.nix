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
      ../../common/packages-highdpi.nix 
    ];

  # Bootloader.

  boot.loader = {
    efi.canTouchEfiVariables = true;  # Required for UEFI
    grub = {
      enable = true;
      efiSupport = true;  # Enable EFI mode
      device = "nodev";  # No device for UEFI (uses EFI partition instead)
      useOSProber = true;  # If dual-booting
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
  
  programs.dconf.enable = true;

  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings = {
      vim.theme.enable = true;
      vim.theme.name = "gruvbox";
      vim.theme.style = "dark";
      vim.highlight.Normal.bg = null;
      vim.highlight.Normal.ctermbg = null;
      vim.statusline.lualine.enable = true;
      vim.autocomplete.nvim-cmp.enable = true;
      vim.languages.nix.enable = true;
      vim.languages.markdown.enable = true;
      vim.lsp.enable = true;
      vim.languages.enableTreesitter = true;
      vim.extraPlugins = {
        vim-css-color = {
          package = pkgs.vimPlugins.vim-css-color;
        };
      };
    };
  };

  qt = {
    enable = true;
    platformTheme = "gtk2";
    style = "gtk2";
  };

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

  services.xserver = {
    enable = true;
    autorun = true;
    dpi = 160;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs (oldAttrs: rec {
        # Use the dwm source from our flake input
        src = inputs.dwm-secondary-src;

        # Fetch our custom config.h from a URL (pin with a fixed sha256)
        configFile = pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/astrolul/dwm/refs/heads/secondary/config.h";
          sha256 = "137jbdazrc0grc8rayi60if3mjfjsgphplj1lfsvvp3n73598ndx";
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

  services.libinput = {
    enable = true;
    touchpad.tapping = false;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    xorg.libX11
    xorg.libXft
    xorg.libXinerama
    imlib2
    freetype
    harfbuzz
    fontconfig
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

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
