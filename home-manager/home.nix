{ config, pkgs, inputs, ... }:

{
  home.username = "astrolul";
  home.homeDirectory = "/home/astrolul";
  home.stateVersion = "25.11";

  imports = 
    [
      ../common/hyprland.nix
    ];

  home.packages = with pkgs; [
    wget
    git
    stow
    feh
    pavucontrol
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
    weechat
    streamrip
    hugo
    mpv
    yt-dlp
    statix
    thonny
    gemini-cli
    (ungoogled-chromium.override { enableWideVine = true; })
    pcmanfm
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
    krita
    corefonts
    foot
    waybar
    wofi
    hyprpaper
    hypridle
    slurp
    grim
    vesktop
    wl-clipboard
    cmatrix
    wofi-power-menu
    wofi-emoji
    parsec-bin
    inetutils
    nmap
    python313Packages.python-kasa
    opencode
    audacity
    superTuxKart
    godot
    bottles
    osu-lazer
    prismlauncher
    efibootmgr
  ];  

  programs = {
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

        if [[ $DISPLAY =~ ^:[0-9]+$ ]] && command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
          tmux attach-session -t default || tmux new-session -s default
        fi
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

 services.dunst = {
   enable = true;
   configFile = "/home/astrolul/nixos/misc/dunstrc";
};

 gtk = {
   enable = true;
   theme = {
     name = "gruvbox-dark";
     package = pkgs.gruvbox-dark-gtk;
   };
   font = {
     name = "FiraCode Nerd Font Regular";
     size = 11;
   };
 };

 home.pointerCursor = {
   gtk.enable = true;   # Ensures GTK apps (including those on Wayland) use this cursor
   hyprcursor.enable = true;   # Registers the cursor for X11 sessions (e.g., root window, WM)
   name = "Bibata-Original-Ice";
   package = pkgs.bibata-cursors;
   size = 24;
 };

 xdg.configFile."gtk-3.0/settings.ini".force = true;

}
