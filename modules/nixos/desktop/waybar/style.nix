{colors}: ''
  * {
      border: none;
      font-family: 'Symbols Nerd Font', 'JetBrainsMono Nerd Font Mono';
      font-size: 14px;
      font-weight: 600;
      margin: 0px;
      padding: 0px;
      border-radius: 0;
  }

  window#waybar {
      background-color: #${colors.base01};
      color: #${colors.base05};
      transition-property: background-color;
      transition-duration: .5s;
  }

  #workspaces {
      background-color: #${colors.base00};
      padding: 0px 3px;
  }

  #custom-sep0 {
     margin-bottom: -32px;
     margin-top: -36px;
     margin-right: -12px;
     font-size: 28px;
     color: #${colors.base00};
  }
  #custom-sep1 {
     margin-bottom: -32px;
     margin-top: -36px;
     margin-left: -12px;
     font-size: 28px;
     color: #${colors.base00};
  }
''
