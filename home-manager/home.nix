{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.username = "astrolul";
  home.homeDirectory = "/home/astrolul";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    wget
    git
    stow
    flashprog
    pciutils
    ffmpeg
    tree
    fastfetch
    pfetch
    htop
    cmus
    nerd-fonts.fira-code
    fira-code
    brightnessctl
    (weechat.override {
      configure =
        { availablePlugins, ... }:
        {
          plugins = with availablePlugins; [ python ];
        };
    })
    streamrip
    hugo
    mpv
    yt-dlp
    statix
    gemini-cli
    xarchiver
    unrar
    nicotine-plus
    gimp3-with-plugins
    bibletime
    kjv
    tetris
    gnome-mahjongg
    jp2a
    extremetuxracer
    mangohud
    libreoffice
    qbittorrent
    corefonts
    vesktop
    wl-clipboard
    cmatrix
    parsec-bin
    inetutils
    nmap
    wireshark
    python313Packages.python-kasa
    audacity
    superTuxKart
    bottles
    prismlauncher
    efibootmgr
    cmusfm
    protonup-rs
    protonvpn-gui
    cider-2
    luanti
    gajim
    dipc
    figlet
    bitwarden-desktop
    gcr
    seahorse
    nixfmt
    kdePackages.kdenlive
    firefox-gnome-theme
    (retroarch.withCores (
      cores: with cores; [
        mgba
        snes9x
      ]
    ))
  ];

  programs = {
    firefox = {
      enable = true;

      profiles.default = {
        # or replace "default" with your profile name (e.g., "personal")
        name = "Default";
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "svg.context-properties.content.enabled" = true;

          "browser.uidensity" = 0; # compact UI
          "browser.theme.dark-private-windows" = false;
          "gnomeTheme.hideSingleTab" = true; # hide tab bar with one tab (toggle via about:config)
          "gnomeTheme.tabsAsHeaderbar" = true; # tabs in headerbar

          "layers.acceleration.force-enabled" = true; # Key workaround from firefox-gnome-theme README & Mozilla bugs
          "gfx.webrender.all" = true;

          "browser.compactmode.show" = true;
        };

        userChrome = ''
          @import "firefox-gnome-theme/share/firefox-gnome-theme/userChrome.css";
          /* Optional: import specific variants, e.g., dark mode or oled */
          /* @import "firefox-gnome-theme/share/firefox-gnome-theme/theme/colors/dark.css"; */
        '';

        userContent = ''
          @import "firefox-gnome-theme/share/firefox-gnome-theme/userContent.css";
        '';
      };
    };
    ptyxis = {
      enable = true;
    };
    chawan = {
      enable = true;
      settings = {
        buffer = {
          images = true;
          autofocus = true;
        };
      };
    };
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    };
    bash = {
      enable = true;
    };
    git = {
      enable = true;
      settings = {
        user.name = "astrolul";
        user.email = "85197489+astrolul@users.noreply.github.com";
      };
    };
    cmus = {
      enable = true;
      theme = "gruvbox";
      extraConfig = ''
        set output_plugin=pulse
        set show_current_bitrate=true
        set status_display_program=cmusfm
        add ~/music
      '';
    };
    fastfetch = {
      enable = true;
    };
    btop = {
      enable = true;
      settings = {
        color_theme = "gruvbox_dark_v2";
        theme_background = false;
        truecolor = true;
      };
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      history.size = 10000;
      initContent = ''
        PS1="%B%F{green}''${''${(%):-%n}:0:1}@''${''${(%):-%m}:0:1}%k %B%F{blue}%1~ %# %b%f%k"

        EDITOR="nvim"
        SUDO_EDITOR="nvim"      

        export PATH="$HOME/.cargo/bin:$PATH"
      '';
      shellAliases = {
        ls = "ls -la";
        mkdir = "mkdir -p";
        cp = "cp -r";
      };
    };
    tmux = {
      enable = true;
      terminal = "tmux-256color";
      shell = "${pkgs.zsh}/bin/zsh";
      extraConfig = ''
        set-option -sa terminal-overrides ",tmux-256color*:Tc"
        set -g status-style bg=default
        set -g status-fg "#fabd2f"
      '';
    };
  };

  home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source =
    "${pkgs.firefox-gnome-theme}/";

  services.gnome-keyring.enable = true;

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

}
