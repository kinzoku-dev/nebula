{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}:
with lib;
with lib.nebula; let
  cfg = config.apps.discord;
in {
  options.apps.discord = with types; {
    enable = mkBoolOpt false "Enable or disable discord";
  };

  config = mkIf cfg.enable {
    system.persist.home.dirs = [
      ".config/vesktop"
      ".config/discord"
    ];
    environment.systemPackages = [
      (inputs.vesktop.legacyPackages."x86_64-linux".vesktop.overrideAttrs {
        desktopItems = [
          (pkgs.makeDesktopItem {
            name = "vesktop";
            desktopName = "Discord";
            exec = "vesktop --enable-features=VaapiIgnoreDriverChecks,VaapiVideoEncoder,VaapiVideoDecoder,CanvasOopRasterization,UseMultiPlaneFormatForHardwareVideo";
            icon = "discord";
            startupWMClass = "vesktop";
            genericName = "Internet Messenger";
            keywords = [
              "discord"
              "vencord"
              "electron"
              "chat"
            ];
            categories = [
              "Network"
              "InstantMessaging"
              "Chat"
            ];
          })
        ];
      })
    ];
    home = {
      configFile = {
        "vesktop/themes/catppuccin.theme.css".source = ./catppuccin.theme.css;
        "discord/settings.json".text = ''
          {
            "IS_MAXIMIZED": false,
            "IS_MINIMIZED": false,
            "OPEN_ON_STARTUP": false,
            "MINIMIZE_TO_TRAY": false,
            "SKIP_HOST_UPDATE": true
          }
        '';
        "vesktop/settings.json".text = ''
              {
              "minimizeToTray": "on",
              "discordBranch": "stable",
              "arRPC": true,
              "splashColor": "rgb(205, 214, 244)",
              "splashBackground": "rgb(30, 30, 46)",
              "splashTheming": true,
              "tray": false,
              "enableMenu": false
          }

        '';
        "vesktop/settings/settings.json".text = ''
                  {
              "notifyAboutUpdates": true,
              "autoUpdate": false,
              "autoUpdateNotification": true,
              "useQuickCss": true,
              "themeLinks": [],
              "enabledThemes": [
                  "catppuccin.theme.css"
              ],
              "enableReactDevtools": true,
              "frameless": false,
              "transparent": false,
              "winCtrlQ": false,
              "macosTranslucency": false,
              "disableMinSize": false,
              "winNativeTitleBar": false,
              "plugins": {
                  "BadgeAPI": {
                      "enabled": true
                  },
                  "CommandsAPI": {
                      "enabled": true
                  },
                  "ContextMenuAPI": {
                      "enabled": true
                  },
                  "MemberListDecoratorsAPI": {
                      "enabled": true
                  },
                  "MessageAccessoriesAPI": {
                      "enabled": true
                  },
                  "MessageDecorationsAPI": {
                      "enabled": true
                  },
                  "MessageEventsAPI": {
                      "enabled": true
                  },
                  "MessagePopoverAPI": {
                      "enabled": true
                  },
                  "NoticesAPI": {
                      "enabled": true
                  },
                  "ServerListAPI": {
                      "enabled": true
                  },
                  "NoTrack": {
                      "enabled": true
                  },
                  "Settings": {
                      "enabled": true,
                      "settingsLocation": "aboveActivity"
                  },
                  "SupportHelper": {
                      "enabled": true
                  },
                  "AlwaysAnimate": {
                      "enabled": false
                  },
                  "AlwaysTrust": {
                      "enabled": true
                  },
                  "AnonymiseFileNames": {
                      "enabled": false
                  },
                  "BANger": {
                      "enabled": true
                  },
                  "BetterFolders": {
                      "enabled": true,
                      "sidebar": true,
                      "showFolderIcon": 1,
                      "closeAllHomeButton": false,
                      "keepIcons": false,
                      "sidebarAnim": true,
                      "closeAllFolders": false,
                      "forceOpen": false,
                      "closeOthers": false
                  },
                  "BetterGifAltText": {
                      "enabled": false
                  },
                  "BetterNotesBox": {
                      "enabled": false,
                      "hide": false,
                      "noSpellCheck": false
                  },
                  "BetterRoleDot": {
                      "enabled": false
                  },
                  "BetterUploadButton": {
                      "enabled": false
                  },
                  "BiggerStreamPreview": {
                      "enabled": false
                  },
                  "BlurNSFW": {
                      "enabled": false
                  },
                  "CallTimer": {
                      "enabled": true,
                      "format": "stopwatch"
                  },
                  "ClearURLs": {
                      "enabled": false
                  },
                  "ColorSighted": {
                      "enabled": false
                  },
                  "ConsoleShortcuts": {
                      "enabled": false
                  },
                  "CopyUserURLs": {
                      "enabled": false
                  },
                  "CrashHandler": {
                      "enabled": true
                  },
                  "CustomRPC": {
                      "enabled": false,
                      "type": 0,
                      "timestampMode": 0
                  },
                  "Dearrow": {
                      "enabled": false
                  },
                  "EmoteCloner": {
                      "enabled": true
                  },
                  "Experiments": {
                      "enabled": false
                  },
                  "F8Break": {
                      "enabled": false
                  },
                  "FakeNitro": {
                      "enabled": true,
                      "enableEmojiBypass": true,
                      "emojiSize": 48,
                      "transformEmojis": true,
                      "enableStickerBypass": true,
                      "stickerSize": 160,
                      "transformStickers": true,
                      "transformCompoundSentence": true,
                      "enableStreamQualityBypass": true
                  },
                  "FakeProfileThemes": {
                      "enabled": false
                  },
                  "FavoriteEmojiFirst": {
                      "enabled": false
                  },
                  "FavoriteGifSearch": {
                      "enabled": true,
                      "searchOption": "hostandpath"
                  },
                  "FixSpotifyEmbeds": {
                      "enabled": false
                  },
                  "ForceOwnerCrown": {
                      "enabled": false
                  },
                  "FriendInvites": {
                      "enabled": false
                  },
                  "GameActivityToggle": {
                      "enabled": false
                  },
                  "GifPaste": {
                      "enabled": true
                  },
                  "GreetStickerPicker": {
                      "enabled": false
                  },
                  "HideAttachments": {
                      "enabled": false
                  },
                  "iLoveSpam": {
                      "enabled": false
                  },
                  "IgnoreActivities": {
                      "enabled": false
                  },
                  "ImageZoom": {
                      "enabled": true,
                      "size": 652.8846153846154,
                      "zoom": 2,
                      "nearestNeighbour": false,
                      "square": false,
                      "zoomSpeed": 0.9794871794871796,
                      "saveZoomValues": true
                  },
                  "InvisibleChat": {
                      "enabled": false
                  },
                  "KeepCurrentChannel": {
                      "enabled": false
                  },
                  "LastFMRichPresence": {
                      "enabled": false
                  },
                  "LoadingQuotes": {
                      "enabled": false,
                      "replaceEvents": true
                  },
                  "MemberCount": {
                      "enabled": true
                  },
                  "MessageClickActions": {
                      "enabled": false
                  },
                  "MessageLinkEmbeds": {
                      "enabled": false
                  },
                  "MessageLogger": {
                      "enabled": false,
                      "deleteStyle": "text",
                      "ignoreBots": false,
                      "ignoreSelf": false,
                      "ignoreUsers": "",
                      "ignoreChannels": "",
                      "ignoreGuilds": ""
                  },
                  "MessageTags": {
                      "enabled": true,
                      "clyde": true
                  },
                  "MoreCommands": {
                      "enabled": false
                  },
                  "MoreKaomoji": {
                      "enabled": false
                  },
                  "MoreUserTags": {
                      "enabled": false
                  },
                  "Moyai": {
                      "enabled": false,
                      "volume": 0.5,
                      "quality": "Normal",
                      "triggerWhenUnfocused": true,
                      "ignoreBots": true,
                      "ignoreBlocked": true
                  },
                  "MutualGroupDMs": {
                      "enabled": false
                  },
                  "NoBlockedMessages": {
                      "enabled": false
                  },
                  "NoDevtoolsWarning": {
                      "enabled": false
                  },
                  "NoF1": {
                      "enabled": false
                  },
                  "NoMosaic": {
                      "enabled": false
                  },
                  "NoPendingCount": {
                      "enabled": false
                  },
                  "NoProfileThemes": {
                      "enabled": false
                  },
                  "NoRPC": {
                      "enabled": false
                  },
                  "NoReplyMention": {
                      "enabled": false
                  },
                  "NoScreensharePreview": {
                      "enabled": false
                  },
                  "NoSystemBadge": {
                      "enabled": false
                  },
                  "NoTypingAnimation": {
                      "enabled": false
                  },
                  "NoUnblockToJump": {
                      "enabled": true
                  },
                  "NormalizeMessageLinks": {
                      "enabled": false
                  },
                  "NSFWGateBypass": {
                      "enabled": false
                  },
                  "OnePingPerDM": {
                      "enabled": false
                  },
                  "oneko": {
                      "enabled": false
                  },
                  "OpenInApp": {
                      "enabled": true,
                      "spotify": false,
                      "steam": true,
                      "epic": false
                  },
                  "Party mode 🎉": {
                      "enabled": false
                  },
                  "PermissionFreeWill": {
                      "enabled": false
                  },
                  "PermissionsViewer": {
                      "enabled": false
                  },
                  "petpet": {
                      "enabled": false
                  },
                  "PictureInPicture": {
                      "enabled": false
                  },
                  "PlainFolderIcon": {
                      "enabled": false
                  },
                  "PlatformIndicators": {
                      "enabled": true,
                      "colorMobileIndicator": true,
                      "list": true,
                      "badges": true,
                      "messages": true
                  },
                  "PreviewMessage": {
                      "enabled": true
                  },
                  "PronounDB": {
                      "enabled": false
                  },
                  "QuickMention": {
                      "enabled": true
                  },
                  "QuickReply": {
                      "enabled": true,
                      "shouldMention": 2
                  },
                  "ReactErrorDecoder": {
                      "enabled": false
                  },
                  "ReadAllNotificationsButton": {
                      "enabled": true
                  },
                  "RelationshipNotifier": {
                      "enabled": true,
                      "notices": false,
                      "offlineRemovals": true,
                      "friends": true,
                      "friendRequestCancels": true,
                      "servers": true,
                      "groups": true
                  },
                  "RevealAllSpoilers": {
                      "enabled": false
                  },
                  "ReverseImageSearch": {
                      "enabled": true
                  },
                  "RoleColorEverywhere": {
                      "enabled": false
                  },
                  "SearchReply": {
                      "enabled": false
                  },
                  "SecretRingToneEnabler": {
                      "enabled": false
                  },
                  "SendTimestamps": {
                      "enabled": false
                  },
                  "ServerListIndicators": {
                      "enabled": true,
                      "mode": 2
                  },
                  "ServerProfile": {
                      "enabled": true
                  },
                  "ShikiCodeblocks": {
                      "enabled": true,
                      "theme": "https://raw.githubusercontent.com/shikijs/shiki/0b28ad8ccfbf2615f2d9d38ea8255416b8ac3043/packages/shiki/themes/dark-plus.json",
                      "tryHljs": "SECONDARY",
                      "useDevIcon": "GREYSCALE",
                      "bgOpacity": 100
                  },
                  "ShowAllMessageButtons": {
                      "enabled": true
                  },
                  "ShowConnections": {
                      "enabled": true,
                      "iconSize": 32,
                      "iconSpacing": 1
                  },
                  "ShowHiddenChannels": {
                      "enabled": false
                  },
                  "ShowMeYourName": {
                      "enabled": false
                  },
                  "ShowTimeouts": {
                      "enabled": false
                  },
                  "SilentMessageToggle": {
                      "enabled": false
                  },
                  "SilentTyping": {
                      "enabled": false
                  },
                  "SortFriendRequests": {
                      "enabled": false
                  },
                  "SpotifyControls": {
                      "enabled": false
                  },
                  "SpotifyCrack": {
                      "enabled": false
                  },
                  "SpotifyShareCommands": {
                      "enabled": false
                  },
                  "StartupTimings": {
                      "enabled": false
                  },
                  "TextReplace": {
                      "enabled": false
                  },
                  "ThemeAttributes": {
                      "enabled": false
                  },
                  "TimeBarAllActivities": {
                      "enabled": false
                  },
                  "Translate": {
                      "enabled": true,
                      "autoTranslate": false
                  },
                  "TypingIndicator": {
                      "enabled": true,
                      "includeMutedChannels": false,
                      "includeBlockedUsers": false,
                      "includeCurrentChannel": true
                  },
                  "TypingTweaks": {
                      "enabled": true,
                      "showAvatars": true,
                      "showRoleColors": true,
                      "alternativeFormatting": true
                  },
                  "Unindent": {
                      "enabled": true
                  },
                  "UnsuppressEmbeds": {
                      "enabled": false
                  },
                  "UrbanDictionary": {
                      "enabled": false
                  },
                  "UserVoiceShow": {
                      "enabled": false
                  },
                  "USRBG": {
                      "enabled": false
                  },
                  "ValidUser": {
                      "enabled": false
                  },
                  "VoiceChatDoubleClick": {
                      "enabled": true
                  },
                  "VcNarrator": {
                      "enabled": false
                  },
                  "VencordToolbox": {
                      "enabled": true
                  },
                  "ViewIcons": {
                      "enabled": true,
                      "format": "webp",
                      "imgSize": "1024"
                  },
                  "ViewRaw": {
                      "enabled": false
                  },
                  "VoiceMessages": {
                      "enabled": true
                  },
                  "VolumeBooster": {
                      "enabled": false
                  },
                  "WhoReacted": {
                      "enabled": false
                  },
                  "Wikisearch": {
                      "enabled": false
                  },
                  "WebRichPresence (arRPC)": {
                      "enabled": false
                  },
                  "WebContextMenus": {
                      "enabled": true,
                      "addBack": true
                  },
                  "WebKeybinds": {
                      "enabled": true
                  },
                  "ClientTheme": {
                      "enabled": false
                  },
                  "FixImagesQuality": {
                      "enabled": false
                  },
                  "SuperReactionTweaks": {
                      "enabled": false
                  },
                  "Decor": {
                      "enabled": false
                  },
                  "NotificationVolume": {
                      "enabled": false
                  },
                  "XSOverlay": {
                      "enabled": false
                  },
                  "BetterGifPicker": {
                      "enabled": false
                  },
                  "FixCodeblockGap": {
                      "enabled": false
                  },
                  "ReviewDB": {
                      "enabled": false
                  },
                  "DisableCallIdle": {
                      "enabled": true
                  },
                  "NewGuildSettings": {
                      "enabled": false
                  },
                  "ChatInputButtonAPI": {
                      "enabled": true
                  },
                  "FixYoutubeEmbeds": {
                      "enabled": false
                  }
              },
              "notifications": {
                  "timeout": 5000,
                  "position": "bottom-right",
                  "useNative": "always",
                  "logLimit": 50
              },
              "cloud": {
                  "authenticated": false,
                  "url": "https://api.vencord.dev/",
                  "settingsSync": false,
                  "settingsSyncVersion": 1710443772510
              }
          }

        '';
      };
    };
  };
}
