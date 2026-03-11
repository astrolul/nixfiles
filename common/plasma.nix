{ pkgs, ... }:

{

  programs.plasma = {
    enable = true;

    input = {
      keyboard = {
        layouts = [
          {
            layout = "gb";
          }
        ];
      };
    };

    #
    # Some high-level settings:
    #
    workspace = {
      clickItemTo = "select";
      lookAndFeel = "org.kde.breezedark.desktop";
      wallpaper = "/home/astrolul/nixos/misc/wallpaper-10.png";
    };

    session = {
      sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    };

    kwin = {
      nightLight = {
        enable = true;
        mode = "automatic";
      };
      effects = {
        wobblyWindows.enable = true;
        translucency.enable = true;
        blur = {
          enable = true;
          strength = 6;
          noiseStrength = 0;
        };
        hideCursor = {
          enable = true;
          hideOnInactivity = 5;
          hideOnTyping = true;
        };
      };
    };

    hotkeys.commands."launch-konsole" = {
      name = "Launch Konsole";
      key = "Meta+Alt+K";
      command = "konsole";
    };

    panels = [
      # Windows-like panel at the bottom
      {
        location = "top";
        opacity = "translucent";
        floating = true;
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.windowlist"
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];

    #
    # Some mid-level settings:
    #
    shortcuts = {
      ksmserver = {
        "Lock Session" = [
          "Screensaver"
          "Meta+Ctrl+Alt+L"
        ];
      };

      kwin = {
        "Expose" = "Meta+,";
        "Switch Window Down" = "Meta+J";
        "Switch Window Left" = "Meta+H";
        "Switch Window Right" = "Meta+L";
        "Switch Window Up" = "Meta+K";
      };
    };

    #
    # Some low-level settings:
    #
    configFile = {
      "baloofilerc"."Basic Settings"."Indexing-Enabled" = false;
      "kwinrc"."org.kde.kdecoration2"."ButtonsOnLeft" = "SF";
      "kwinrc"."Desktops"."Number" = {
        value = 8;
        # Forces kde to not change this value (even through the settings app).
        immutable = true;
      };
      "kdeglobals"."General"."accentColorFromWallpaper" = true;
    };
  };
}
