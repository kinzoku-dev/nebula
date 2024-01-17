{
  colors,
  config,
}: {
  mainBar = {
    position = "top";
    layer = "top";
    height = 30;

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
      format = " {}%";
    };
    "backlight" = {
      format = " {percent}%";
    };
    "network" = {
      format-wifi = "  {essid} {signalStrength}%";
      format-ethernet = "󰈁 {ifname}: {ipaddr}/{cidr}";
      format-disconnected = "󰌙  Disconnected";
      # on-click = "wifi-menu";
      # on-click-release = "sleep 0";
      tooltip-format = "{essid} {signalStrength}%";
    };
  };
}
