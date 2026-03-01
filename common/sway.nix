{
  config,
  lib,
  pkgs,
  ...
}:

{
  wayland.windowManager.sway = {
    enable = true;  # Uncomment if not enabled elsewhere (e.g. via programs.sway in NixOS config)
    wrapperFeatures.gtk = true; # Fixes common issues with GTK 3 apps

    config = rec {
      modifier = "Mod4";
      left = "h";
      down = "j";
      up = "k";
      right = "l";

      # Your preferred terminal emulator
      terminal = "foot";

      # Your preferred application launcher
      menu = "wmenu-run";

      # floating_modifier $mod normal (normal is the default behaviour)
      # floatingModifier = modifier;

      ### Output configuration
      output = {
        "*" = {
          bg = "${pkgs.sway}/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png fill";
       
          scale = 1.25;
        };
      };

      ### Key bindings (exact match to the default sway config)
      keybindings = {
        # Basics
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+Shift+c" = "kill";
        "${modifier}+d" = "exec ${menu}";
        "${modifier}+Shift+r" = "reload";
        "${modifier}+Shift+q" = ''exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'';

        # Moving around (hjkl + arrows)
        "${modifier}+${left}" = "focus left";
        "${modifier}+${down}" = "focus down";
        "${modifier}+${up}" = "focus up";
        "${modifier}+${right}" = "focus right";
        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "${modifier}+Shift+${left}" = "move left";
        "${modifier}+Shift+${down}" = "move down";
        "${modifier}+Shift+${up}" = "move up";
        "${modifier}+Shift+${right}" = "move right";
        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        # Workspaces
        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        # Layout stuff
        "${modifier}+b" = "splith";
        "${modifier}+v" = "splitv";
        "${modifier}+s" = "layout stacking";
        "${modifier}+w" = "layout tabbed";
        "${modifier}+e" = "layout toggle split";
        "${modifier}+f" = "fullscreen";
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";
        "${modifier}+a" = "focus parent";

        # Scratchpad
        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        # Resizing containers (enter mode)
        "${modifier}+r" = ''mode "resize"'';
      };

      modes = {
        resize = {
          # hjkl
          "${left}" = "resize shrink width 10px";
          "${down}" = "resize grow height 10px";
          "${up}" = "resize shrink height 10px";
          "${right}" = "resize grow width 10px";

          # arrow keys
          "Left" = "resize shrink width 10px";
          "Down" = "resize grow height 10px";
          "Up" = "resize shrink height 10px";
          "Right" = "resize grow width 10px";

          # exit mode
          "Return" = "mode default";
          "Escape" = "mode default";
        };
      };

      ### Status Bar
      bars = [
        {
          position = "bottom";
          statusCommand = "while date +'%Y-%m-%d %X'; do sleep 1; done";

          colors = {
            statusline = "#ffffff";
            background = "#323232";
            inactiveWorkspace = "#32323200 #32323200 #5c5c5c";
          };
        }
      ];
    };

    ### Special keys that require --locked (not supported in the keybindings attrset)
    extraConfig = ''
      # Special keys to adjust volume via PulseAudio
      bindsym --locked XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
      bindsym --locked XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5%
      bindsym --locked XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5%
      bindsym --locked XF86AudioMicMute exec pactl set-source-mute @DEFAULT_SOURCE@ toggle

      # Special keys to control media via playerctl
      bindsym --locked XF86AudioPlay exec playerctl play-pause
      bindsym --locked XF86AudioPause exec playerctl play-pause
      bindsym --locked XF86AudioPrev exec playerctl previous
      bindsym --locked XF86AudioNext exec playerctl next
      bindsym --locked XF86AudioStop exec playerctl stop

      # Special keys to adjust brightness via brightnessctl
      bindsym --locked XF86MonBrightnessDown exec brightnessctl set 5%-
      bindsym --locked XF86MonBrightnessUp exec brightnessctl set 5%+

      # Special key to take a screenshot with grim
      bindsym Print exec grim
    '';
  };
}
