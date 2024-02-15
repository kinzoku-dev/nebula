{
  colors,
  config,
}: {
  mainBar = {
    layer = "top";
    margin = "8px 10px -2px 10px";

    modules-left = ["custom/menu" "hyprland/workspaces"];
    modules-center = ["clock"];
    modules-right = ["cpu" "memory" "backlight" "network" "tray"];

    "hyprland/workspaces" = {
      active-only = "false";
      on-scroll-up = "hyprctl dispatch workspace e+1";
      on-scroll-down = "hyprctl dispatch workspace e-1";
      disable-scroll = "false";
      all-outputs = "true";
      format = "{icon}";
      on-click = "activate";
      format-icons = {
        active = "";
        default = "󰺕";
        empty = "";
        urgent = "󰀨";
      };
      sort-by-number = true;
      persistent-workspaces = builtins.listToAttrs (
        map (m: {
          name = m.name;
          value = m.workspaces;
        })
        (config.desktop.hyprland.displays)
      );
    };

    "custom/menu" = {
      format = "";
      on-click = "rofi-drun";
      on-click-release = "sleep 0";
    };

    tray = {
      spacing = 8;
    };

    "clock" = {
      format = " {:%I:%M %p}";
      format-alt = "󰸗 {:%A, %B %d, %Y}";
    };

    "cpu" = {
      format = " {usage}%";
      tooltip = false;
    };
    "memory" = {
      format = " {percentage}%";
    };
    "backlight" = {
      format = " {percent}%";
    };
    "network" = {
      format-wifi = " {essid} {signalStrength}%";
      format-ethernet = "󰈁 {ifname}: {ipaddr}/{cidr}";
      format-disconnected = "󰌙 Disconnected";
      on-click = "wifi-menu";
      on-click-release = "sleep 0";
      tooltip-format = "{essid} {signalStrength}%";
    };
    "group/group-audio" = {
      orientation = "horizontal";
      drawer = {
        transition-duration = 500;
        transition-left-to-right = true;
        children-class = "group-audio-child";
      };
      modules = [
        "pulseaudio"
        "pulseaudio/slider"
      ];
    };

    "pulseaudio" = {
      format = "{icon} {volume}%";
      format-muted = "󰖁 Muted";
      format-bluetooth = "{icon}󰂯 {volume}%";
      format-icons = {
        phone = "";
        headphone = "󰋋";
        portable = "";
        car = "";
        speaker = "󰓃";
        hdmi = "󰽟";
        default = ["󰕿" "󰖀" "󰕾"];
      };
      scroll-step = 1;
      on-click = "kitty pulsemixer";
    };
  };
}
