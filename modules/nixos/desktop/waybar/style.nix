{colors}: ''
  * {
      font-family: JetBrainsMono Nerd Font Mono;
      font-size: 14px;
      border-radius: 0px;
  }

  window#waybar {
      background-color: #${colors.base01};
      border-radius: 0px;
      color: #${colors.base05};
  }

  button {
      border: none;
  }

  button:hover {
      background: inherit;
  }

  #workspaces {
      margin: 5px 0;
      border-radius: 5px;
      padding: 0 7px;
      background-color: #${colors.base00};
  }

  #workspaces button {
    color: #${colors.base05};
    padding: 5px;
    transition: font-size 300ms;
    font-size: 20px;
  }

  #workspaces button label {
    font-size: 20px;
  }

  #workspaces button.empty {
    color: #${colors.base04};
  }

  #workspaces button.active {
      color: #${colors.base0D};
  }

  #workspaces button:hover {
      background: rgba(0, 0, 0, 0.2);
      box-shadow: inherit;
      text-shadow: inherit;
      border: none;
  }

  #workspaces button.urgent {
      color: #${colors.base08};
  }

  #clock,
  #custom-cava,
  #group-audio {
      border-radius: 5px;
      padding: 0 10px;
      color: #${colors.base05};
      background-color: #${colors.base00};
      margin: 5px 0;
      margin-left: 5px;
  }

  #custom-wlogout {
      border-radius: 5px;
      padding: 0 10px;
      color: #${colors.base05};
      background-color: #${colors.base00};
      margin: 5px 0;
      margin-right: 5px;
  }

  #custom-wlogout {
      color: #${colors.base08};
  }

  #pulseaudio, #pulseaudio-slider {
      background-color: #${colors.base00};
      color: #${colors.base05};
      border-radius: 5px;
  }

  #pulseaudio-slider {
      min-width: 100px;
      padding: 0;
      margin-right: 10px;
  }

  slider {
      margin: 0;
      padding: 0;
      min-height: 0px;
      min-width: 0px;
      border-radius: 5px;
      box-shadow: none;
      background-color: #b4befe;
  }
''
