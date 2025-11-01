# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };
  
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "weekly";

  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 14d";
  nix.settings.auto-optimise-store = true;
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "uk";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.astrolul = {
    isNormalUser = true;
    description = "astrolul";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };
  
#  home-manager = {
#    extraSpecialArgs = { inherit inputs; };
#    users = {
#      "astrolul" = import ./home.nix;
#    };
#  };

  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  environment.variables = {
    EDITOR="nvim";
    SUDO_EDITOR="nvim";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    git
    stow
    nerd-fonts.terminess-ttf
    feh
    pavucontrol
    flashprog
    inputs.dmenu-src.packages.${pkgs.system}.default
    inputs.slstatus-src.packages.${pkgs.system}.default
    (inputs.st-src.packages.${pkgs.system}.default.overrideAttrs (oldAttrs: rec {
      configFile = fetchurl {
        url = "https://raw.githubusercontent.com/astrolul/st/main/config.h";  # Adjust branch/ref if needed (e.g., /some-commit/config.h)
        sha256 = "1cx96pq7sgs3i2zpgln0zwlbqnsndvv61l788dlbas2pc6wwy9y9";  # Replace with actual hash (see below)
      };
      postPatch = (oldAttrs.postPatch or "") + "\n cp ${configFile} config.h";
    }))
  ];
  
  programs.zsh.enable = true;

  hardware.enableAllFirmware = true;
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.pipewire.wireplumber.extraConfig.bluetoothEnhancements = {
    "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
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
#    alsa.enable = true;
#    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver = {
    enable = true;
    autorun = true;
    dpi = 100;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = inputs.dwm-src;
	buildInputs = with pkgs; [
	  xorg.libX11
	  xorg.libXft
	  xorg.libXinerama
	  imlib2
	  freetype
	  harfbuzz
	  fontconfig
        ];
      };
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
