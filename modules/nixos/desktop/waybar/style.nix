{colors}: ''
  * {
      border: none;
      font-family: JetBrainsMono Nerd Font, sans-serif;
      font-size: 14px;
  }

  window#waybar {
      background-color: #${colors.base01};
      border-radius: 6px;
      color: #${colors.base05};
      opacity: 1;
      margin-bottom: -7px;
  }

  window#waybar.hidden {
      opacity: 0.2;
  }

  #workspaces,
  #clock,
  #cpu,
  #memory,
  #backlight,
  #network,
  #language,
  #privacy,
  #tray {
      background-color: #${colors.base00};
      padding: 0 10px;
      margin: 5px 2px 5px 2px;
      border: 1px solid rgba(0, 0, 0, 0);
      border-radius: 6px;
      background-clip: padding-box;
  }

  #workspaces button {
      background-color: #${colors.base00};
      padding: 0 5px;
      min-width: 20px;
      color: #${colors.base05};
  }

  #workspaces button:hover {
      background-color: rgba(0, 0, 0, 0)
  }

  #workspaces button.active {
      color: #${colors.base07};
  }

  #workspaces button.urgent {
      color: #${colors.base08};
  }

  #custom-menu {
      color: #${colors.base0D};
      font-size: 18px;
      padding: 0 4px;
      margin: 5px 2px 5px 2px;
      border: 1px solid rgba(0, 0, 0, 0);
      border-radius: 6px;
      background-clip: padding-box;
  }

  #privacy-item.screenshare {
    color: #${colors.base09};
  }
  #privacy-item.audio-in {
    color: #${colors.base08};
  }
  #privacy-item.audio-out {
    color: #${colors.base0B};
  }
''
