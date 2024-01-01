{
  colors,
  config,
}: {
  mainBar = {
    position = "top";
    layer = "top";
    height = 20;

    modules-left = [
    ];

    modules-center = [
      "custom/sep0"
      "hyprland/workspaces"
      "custom/sep1"
    ];

    modules-right = [
    ];

    "custom/sep0" = {
      format = "";
      rotate = 180;
      tooltip = false;
    };
    "custom/sep1" = {
      format = "";
      rotate = 180;
      tooltip = false;
    };

    "hyprland/workspaces" = {
      format = "{icon}";
      format-icons = {
        empty = "";
        active = "";
        default = "";
        urgent = "";
      };
      on-click = "activate";
      on-scroll-up = "hyprctl dispatch workspace e+1";
      on-scroll-down = "hyprctl dispatch workspace e-1";
      sort-by-number = true;
      persistent-workspaces = builtins.listToAttrs (
        map (m: {
          name = m.name;
          value = m.workspaces;
        })
        (config.desktop.hyprland.displays)
      );
    };

    "clock" = {
      format = "{:%I:%M %p}";
    };

    "group/group-audio" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        children-class = "audio-child";
        transition-left-to-right = false;
      };
      tooltip = false;
      modules = [
        "pulseaudio"
        "pulseaudio/slider"
      ];
    };

    pulseaudio = {
      format = "{icon}";
      format-muted = "󰓄 {format_source}";
      format-alt = "{format_source} {volume}% {icon}";
      format-bluetooth = "󰦢";
      format-bluetooth-muted = "󰓄";
      format-source = "{volume}% <span font='11'></span>";
      format-source-muted = "<span font='11'></span>";
      format-icons = {
        default = ["󰜟 "];
        headphone = "<span font='11'>󰋋 </span>";
      };
      tooltip = false;
      on-click = "{alt}";
      on-click-right = "kitty pulsemixer";
    };

    "pulseaudio/slider" = {
      min = 0;
      max = 100;
      orientation = "horizontal";
    };

    "custom/launcher" = {
      format = "";
      on-click = "anyrun";
      on-click-right = "pkill anyrun";
    };
    "custom/wlogout" = {
      format = "⏻";
      tooltip = false;
      on-click = "wlogout";
    };

    "group/group-menu" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        children-class = "menu-child";
        transition-left-to-right = true;
      };
      tooltip = false;
      modules = [
        "custom/launcher"
        "custom/wlogout"
      ];
    };

    tray = {
      spacing = 10;
      reverse-direction = true;
    };
  };
}
