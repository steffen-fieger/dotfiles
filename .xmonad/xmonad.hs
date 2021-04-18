-- IMPORTS
import XMonad
import XMonad.Config.Desktop
import XMonad.Layout.Spiral


-- Customize Stuff
myTerminal      = "xterm"
myModMask       = mod4Mask  -- Win key

myBorderWidth       = 3
myNormalBorderColor   = "#839496"
myFocusedBorderColor  = "#dc322f"

myLayouts = myLayoutTall ||| myLayoutSpiral ||| myLayoutFull
    where
        myLayoutTall = Tall 1 (3/100) (1/2) 
        myLayoutSpiral = spiral (0.856) 
        myLayoutFull = Full


-- Do stuff
main = xmonad desktopConfig
        { terminal      = myTerminal
        , modMask       = myModMask
        , borderWidth   = myBorderWidth
        , normalBorderColor = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , layoutHook    = myLayouts
        }
