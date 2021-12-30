import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig(additionalKeys)

baseConfig = desktopConfig

main = xmonad $ baseConfig
  { terminal = "alacritty"
  , modMask = mod4Mask
  , layoutHook = avoidStruts $ layoutHook baseConfig
  } `additionalKeys`
  [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
  , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
  , ((0, xK_Print), spawn "scrot")
  , ((mod4Mask, xK_d), spawn "rofi -show run")
  ]
