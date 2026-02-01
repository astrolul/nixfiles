{
  config,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib.gvariant) mkInt32 mkDouble; # Helpers available module-wide
in
{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome.core-apps.enable = true;
  services.gnome.core-developer-tools.enable = true;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    epiphany
    gedit
    geary
    gnome-console
  ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.appindicator
    libayatana-appindicator
    gnomeExtensions.desktop-cube
    gnomeExtensions.blur-my-shell
  ];

  services.udev.packages = [
    pkgs.gnome-settings-daemon
  ];

  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [
        "org.gnome.Ptyxis.desktop"
      ];
    };
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {

        settings = {
          "org/gnome/mutter" = {
            experimental-features = [ "scale-monitor-framebuffer" ];
          };

          "org/gnome/desktop/interface" = {
            font-name = "FiraCode Nerd Font 11"; # Interface font (UI elements, menus, etc.)
            document-font-name = "FiraCode Nerd Font 11"; # Used in documents/apps (e.g., LibreOffice)
            monospace-font-name = "FiraCode Nerd Font 13"; # Terminal/code editors
            text-scaling-factor = 1.0;
            accent-color = "yellow"; # Change to your preferred color
          };

          "org/gnome/Ptyxis/Profiles/bbf1f97b6556ccdc7c6444a3697aacfa" = {
            palette = "Gruvbox";
          };

          "org/gnome/Ptyxis" = {
            visual-bell = false;
            audible-bell = false;
            restore-session = false;
            default-profile-uuid = "bbf1f97b6556ccdc7c6444a3697aacfa";
          };

          "org/gnome/Ptyxis/Shortcuts" = {
            new-tab = "<Control>b";
          };

          "org/gnome/desktop/wm/preferences" = {
            titlebar-font = "FiraCode Nerd Font 11";
            action-middle-click-titlebar = "minimize";
            button-layout = "appmenu:minimize,close";
          };

          "org/gnome/desktop/background" = {
            picture-uri = "file:///home/astrolul/nixos/misc/anime.jpeg";
            picture-uri-dark = "file:///home/astrolul/nixos/misc/anime.jpeg";
            picture-options = "zoom";
          };

          "org/gnome/shell/extensions/dash-to-dock" = {
            always-center-icons = true;
            autohide = true;
            background-opacity = 0.50;
            dash-max-icon-size = lib.gvariant.mkInt32 64;
            dock-fixed = false;
            dock-position = "BOTTOM";
            extend-height = false;
            height-fraction = 0.90000000000000002;
            intellihide = true;
            show-apps-at-top = false;
            show-mounts = false;
            show-show-apps-button = true;
            show-trash = false;
            transparency-mode = "FIXED";
          };

          "org/gnome/shell/extensions/appindicator" = {
            icon-size = lib.gvariant.mkInt32 22; # pixel size (wrap integers!)
            icon-padding = lib.gvariant.mkInt32 4;
            tray-pos = "right"; # or "left"
          };

          "org/gnome/Console" = {
            audible-bell = false; # Disables the audible bell sound
            visual-bell = false;
          };

          # Global / main schema
          "org/gnome/shell/extensions/blur-my-shell" = {
            settings-version = mkInt32 2;
          };

          # App folders (blur on app folders/dialogs)
          "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
            brightness = mkDouble 0.6;
            sigma = mkInt32 30;
          };

          # Applications (blur behind windows)
          "org/gnome/shell/extensions/blur-my-shell/applications" = {
            blur = false;
            blur-on-overview = false;
            enable-all = false;
          };

          # Coverflow Alt-Tab (window switcher)
          "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab" = {
            pipeline = "pipeline_default";
          };

          # Dash to Dock (your bottom dock; custom brightness/sigma, rounded pipeline)
          "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
            blur = true;
            brightness = mkDouble 0.47;
            override-background = true;
            pipeline = "pipeline_default_rounded";
            sigma = mkInt32 37;
            static-blur = true;
            style-dash-to-dock = mkInt32 2; # 2 = dark (matches your Gruvbox preference)
            unblur-in-overview = false;
          };

          # Lockscreen
          "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
            pipeline = "pipeline_default";
          };

          # Overview (static blur on workspace grid)
          "org/gnome/shell/extensions/blur-my-shell/overview" = {
            pipeline = "pipeline_default";
          };

          # Panel (top bar; now with static blur enabled)
          "org/gnome/shell/extensions/blur-my-shell/panel" = {
            brightness = mkDouble 0.6;
            force-light-text = false;
            pipeline = "pipeline_default";
            sigma = mkInt32 30;
            static-blur = true; # Changed from previous false → true (static blur for better performance/consistency)
            unblur-in-overview = true;
          };

          # Screenshot UI
          "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
            pipeline = "pipeline_default";
          };

          # Window list (taskbar-like if enabled; only brightness set here)
          "org/gnome/shell/extensions/blur-my-shell/window-list" = {
            brightness = mkDouble 0.6;
            # sigma not present in this dump (uses default or previously set value if any)
          };

          "org/gnome/system/location" = {
            enabled = true;
          };

          "org/gnome/desktop/peripherals/touchpad" = {
            click-method = "areas"; # Use this instead if you prefer physical bottom-right press
          };

          "org/gnome/shell" = {
            favorite-apps = [
              "firefox.desktop"
              "org.gnome.Ptyxis.desktop" # Terminal
              "org.gajim.Gajim.desktop"
              "vesktop.desktop"
              "bitwarden.desktop"
              "cider-2.desktop"
              "org.wireshark.Wireshark.desktop"
              "org.gnome.Nautilus.desktop" # Files
            ];
            disable-user-extensions = false; # important if you have any other extensions
            enabled-extensions = [
              "dash-to-dock@micxgx.gmail.com"
              "appindicator@ubuntu.com"
              "appindicatorsupport@rgcjonas.gmail.com"
              "desktop-cube@schneegans.github.com"
              "blur-my-shell@aunetx"
              "gsconnect@andyholmes.github.io"
            ];
          };

        };

      }
    ];
  };
}
