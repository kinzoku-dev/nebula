{
  colors,
  config,
}: {
  mainBar = {
    position = "top";
    layer = "top";
    height = 40;
    spacing = 10;

    modules-left = [
      "clock"
      "custom/cava"
      "group/group-audio"
    ];

    modules-center = ["hyprland/workspaces"];

    modules-right = [
      "custom/wlogout"
    ];

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

    "custom/wlogout" = {
      format = "⏻";
      tooltip = false;
      on-click = "wlogout";
    };

    "custom/cava" = {
      format = "{}";
      return-type = "text";
      max-length = 40;
      escape = true;
      exec = "$HOME/.config/waybar/scripts/cava";
    };

    "group/group-audio" = {
      orienatation = "inherit";
      drawer = {
        transition-duration = 500;
        children-class = "";
        transition-left-to-right = true;
      };
      modules = [
        "pulseaudio"
        "pulseaudio/slider"
      ];
    };

    "pulseaudio" = {
      format = "{icon} {volume}%";
      format-muted = "󰸈 Muted";
      format-icons = {
        default = ["󰕿" "󰖀" "󰕾"];
      };
      on-click = "pavucontrol";
    };

    "pulseaudio/slider" = {
      min = 0;
      max = 100;
      orienatation = "horizontal";
    };
  };
}
