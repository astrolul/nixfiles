{
  config,
  pkgs,
  lib,
  ...
}:

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
  ];

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

          "org/gnome/Ptyxis/Profiles/8107591df992b3f119b55c31697aa615/palette" = {
            palette = "Gruvbox";
          };

          "org/gnome/Ptyxis" = {
            visual-bell = false;
            audible-bell = false;
            restore-session = false;
          };

          "org/gnome/desktop/wm/preferences" = {
            titlebar-font = "FiraCode Nerd Font 11";
            action-middle-click-titlebar = "minimize";
            button-layout = "appmenu:minimize,close";
          };

          "org/gnome/desktop/background" = {
            picture-uri = "file:///home/astrolul/nixos/misc/saturn.jpg";
            picture-uri-dark = "file:///home/astrolul/nixos/misc/saturn.jpg";
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
            show-apps-at-top = true;
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
              "org.gnome.Nautilus.desktop" # Files
            ];
            disable-user-extensions = false; # important if you have any other extensions
            enabled-extensions = [
              "dash-to-dock@micxgx.gmail.com"
              "appindicator@ubuntu.com"
            ];
          };

        };

      }
    ];
  };
}
