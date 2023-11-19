{colors}: ''
  * {
      all: unset;
  }

  .txt {
      color: #${colors.base05};
  }

  .bar, .bar-child {
      min-height: 24px;
      background-color: #${colors.base00};
      padding: 8px 0px;
  }

  .bar-ws {
      min-height: 24px;
      min-width: 24px;
      border-radius: 999px;
      background-color: #${colors.base00};
      color: #${colors.base05};
      margin: 4px 5px;
  }

  .bar-ws-active {
      min-height: 24px;
      min-width: 24px;
      border-radius: 999px;
          background: linear-gradient(
            58deg,
            #${colors.base0E},
            #${colors.base0E},
            #${colors.base0E},
            #${colors.base0D},
            #${colors.base0D},
            #${colors.base0E},
            #${colors.base08}
          );
      background-size: 200% 200%;
      color: #${colors.base01};
      animation: colored-gradient 20s ease infinite;
      margin: 4px 5px;
  }

        @keyframes colored-gradient {
          0% {
            background-position: 71% 0%;
          }
          50% {
            background-position: 30% 100%;
          }
          100% {
            background-position: 71% 0%;
          }
        }

  .bar-ws-empty {
      background-color: #${colors.base00};
      color: #555566;
      min-height: 24px;
      min-width: 24px;
      border-radius: 999px;
      margin: 4px 5px;
  }

  .spotify, .spotify-child {
      background-color: #${colors.base00};
  }
''
