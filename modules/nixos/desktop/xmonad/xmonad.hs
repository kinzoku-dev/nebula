import XMonad

import XMonad.Layout.Spacing
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Ungrab
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Layout.NoBorders (noBorders, smartBorders)
import XMonad.Layout.ToggleLayouts (ToggleLayout(..), toggleLayouts)
import qualified Data.Map                            as M
import qualified XMonad.StackSet                     as W
import XMonad.Util.SpawnOnce
import XMonad.Hooks.ManageDocks ( avoidStruts )

import XMonad.Layout.Fullscreen

import           XMonad.Hooks.EwmhDesktops             ( ewmh
                                                       , ewmhFullscreen
                                                       )

-- Imports for Polybar --
import qualified Codec.Binary.UTF8.String              as UTF8
import qualified DBus                                  as D
import qualified DBus.Client                           as D
import           XMonad.Hooks.DynamicLog

import           XMonad.Hooks.FadeInactive             ( fadeInactiveLogHook )


main :: IO ()
main = xmonad . ewmh . ewmhFullscreen . withSB myXmobarPP $ def
  { terminal = "kitty"
  , layoutHook = avoidStruts $ myLayouts
  , startupHook = myStartupHook
  , focusedBorderColor = "#f38ba8"
  }
  `additionalKeysP`
  [ ("M-S-s", spawn "flameshot gui")
  , ("M-f", sendMessage (Toggle "Full"))
  , ("M-t", withFocused toggleFloat)
  ]  
  where
            toggleFloat w = windows (\s -> if M.member w (W.floating s)
                            then W.sink w s
                            else (W.float w (W.RationalRect (1/3) (1/4) (1/2) (4/5)) s))


-- Layouts
myLayouts = toggleLayouts (noBorders Full) (myTiled)
    where
        myTiled = spacingWithEdge 5 $ Tall 1 (3/100) (1/2)
        myFullscreen = Tall 1 (3/100) (1/2)

myStartupHook = do
    spawnOnce "xhost +localhost"
    spawnOnce "picom &"
    spawnOnce "nitrogen --set-zoom-fill --random ~/.config/wallpapers --save"

myXmobarPP = statusBarProp "xmobar ~/.config/xmobar/.xmobarrc" (pure pp)

pp = xmobarPP {
          ppCurrent = xmobarColor "#f38ba8" "" -- . wrap ("<box type=Bottom width=2 mb=5 color=#6690C4>") "</box>"
          , ppVisible = xmobarColor "#89b4fa" ""
          , ppHidden = xmobarColor "#f38ba8" "" . wrap "*" ""
          , ppWsSep = "  "
          , ppOrder = \(ws:l:t:ex) -> [ws]++ex++[t]
}

