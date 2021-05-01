-- IMPORTS
import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spiral
import qualified XMonad.StackSet as W
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import System.IO


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
    [ className =? "firefox"        --> doShift (myWorkspaces !! 0)
    , className =? "Thunderbird"    --> doShift (myWorkspaces !! 1)
    , className =? "vlc"            --> doShift (myWorkspaces !! 3)
    , (className =? "firefox" <&&> resource =? "Dialog")        --> doFloat
    , (className =? "Thunderbird" <&&> resource =? "Dialog")    --> doFloat
    ]

myLayoutHook = (myLayoutFull ||| myLayoutTall ||| myLayoutSpiral)
    where
        myLayoutFull = Full
        myLayoutTall = Tall 1 (3/100) (1/2) 
        myLayoutSpiral = spiral (0.856) 

myStartupHook = do
    spawnOnce "nitrogen --restore &"
    spawnOnce "picom &"


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
        }
