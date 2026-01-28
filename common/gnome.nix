{ config, pkgs, ... }:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Your existing settings...
  services.gnome.core-apps.enable = true;
  services.gnome.core-developer-tools.enable = true;
  services.gnome.games.enable = false;
  #  environment.gnome.excludePackages = with pkgs; [
  #   gnome-tour
  #   gnome-user-docs
  #   epiphany
  #   gedit
  #   geary
  #  ];

  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-dock
  ];

  # Enable fractional scaling (150% will appear in Settings > Displays)
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {

        lockAll = true;

        settings = {
          "org/gnome/mutter" = {
            experimental-features = [ "scale-monitor-framebuffer" ];
          };

          "org/gnome/desktop/background" = {
            picture-uri       = "file:///home/astrolul/nixos/misc/saturn.jpg";
            picture-uri-dark  = "file:///home/astrolul/nixos/misc/saturn.jpg";
            picture-options   = "zoom";
          };

          "org/gnome/Console" = {
            audible-bell = false; # Disables the audible bell sound
            visual-bell = false;
          };

          "org/gnome/desktop/peripherals/touchpad" = {
            click-method = "areas"; # Use this instead if you prefer physical bottom-right press
          };

          # ← Add this block for pinned dock apps
          "org/gnome/shell" = {
            favorite-apps = [
              "firefox.desktop"
              "org.gnome.Console.desktop" # Terminal
              "org.gnome.Nautilus.desktop" # Files
              "nvim.desktop" # Text Editor (example)
              "Cider.desktop"
              # Add more here, e.g.:
              # "codium.desktop"               # VS Codium
              # "spotify.desktop"              # Spotify (if installed)
            ];
          };

          "org/gnome/desktop/interface" = {
            monospace-font-name = "FiraCode Nerd Font 13"; # Affects Console + other apps if no custom
          };

        };

      }
    ];
  };
}
