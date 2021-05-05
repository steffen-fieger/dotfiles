-- IMPORTS
import System.IO
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Spiral
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import qualified XMonad.StackSet as W


-- Variables
myTerminal              = "xterm"
myModMask               = mod4Mask -- Win key
myBorderWidth           = 2
myNormalBorderColor     = "#839496"
myFocusedBorderColor    = "#dc322f"
myWorkspaces            = ["www", "com", "doc", "media"]

windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset


-- Hooks
myManageHook = composeAll
    [ className =? "confirm"        --> doFloat
    , className =? "file_progress"  --> doFloat
    , className =? "dialog"         --> doFloat
    , className =? "download"       --> doFloat
    , className =? "error"          --> doFloat
    , className =? "notification"   --> doFloat
    , className =? "splash"         --> doFloat
    , className =? "toolbar"        --> doFloat
    , (className =? "firefox"       <&&> resource =? "Dialog")  --> doFloat
    , (className =? "Thunderbird"   <&&> resource =? "Dialog")  --> doFloat
    , isFullscreen --> doFullFloat
    , className =? "firefox"        --> doShift (myWorkspaces !! 0)
    , className =? "Thunderbird"    --> doShift (myWorkspaces !! 1)
    , className =? "vlc"            --> doShift (myWorkspaces !! 3)
    ]

myLayoutHook = (myFull ||| myTall ||| myMirrorTall ||| mySpiral)
    where
        myFull          = Full
        myTall          = Tall 1 (3/100) (1/2)
        myMirrorTall    = Mirror (myTall)
        mySpiral        = spiral (0.856)

myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom &"


-- Key Bindings
myKeyBindings =
    [ ("M-S-p", spawn "dmenu_run -i -p \"Run: \"")      -- dmenu
    , ("M-p k", spawn "~/dmenu-scripts/dmenukill")      -- dmenukill-Script
    , ("M-p s", spawn "~/dmenu-scripts/dmenusearch")    -- dmenusearch-Script
    ]


-- Do Stuff
main = do
    xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobar.hs"
    xmonad $ docks desktopConfig
        { manageHook            = manageDocks <+> myManageHook <+> manageHook desktopConfig
        , layoutHook            = avoidStruts $ myLayoutHook
        , startupHook           = myStartupHook
        , logHook               = dynamicLogWithPP xmobarPP
                { ppOutput          = hPutStrLn xmproc
                , ppCurrent         = xmobarColor "#859900" "" . wrap "[" "]"
                , ppVisible         = xmobarColor "#859900" ""
                , ppHidden          = xmobarColor "#268bd2" "" . wrap "" "*"
                , ppHiddenNoWindows = xmobarColor "#6c71c4" ""
                , ppUrgent          = xmobarColor "#dc322f" "" . wrap "!" "!"
                , ppTitle           = xmobarColor "#93a1a1" "" . shorten 60
                , ppSep             = "<fc=#839496>|</fc>"
                , ppExtras          = [windowCount]
                , ppOrder           = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                }
        , terminal              = myTerminal
        , modMask               = myModMask
        , borderWidth           = myBorderWidth
        , normalBorderColor     = myNormalBorderColor
        , focusedBorderColor    = myFocusedBorderColor
        , workspaces            = myWorkspaces
        } `additionalKeysP` myKeyBindings
