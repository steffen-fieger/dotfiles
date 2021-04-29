Config { font = "xft:DejaVu Sans Mono Nerd Font:pixelsize=12:antialias=true:hinting=true"
    , bgColor = "#002b36"
    , fgColor = "#839496"
    , border = BottomB
    , borderColor = "#073642"
    , borderWidth = 3
    , position = Top
    , lowerOnStart = True
    , commands = [ Run Cpu ["-t", "<fc=#cb4b16>\xf108 </fc><total>%"] 10
        , Run Memory ["-t", "<fc=#dc322f>\xf85a </fc><usedratio>%"] 10
        , Run Swap ["-t", "<fc=#dc322f>\xf7c9 </fc><usedratio>%"] 10
        , Run Network "wlp11s0" ["-t", "<fc=#d33682>\xf0ab </fc><rx> <fc=#d33682>\xf0aa </fc><tx>"] 10
        , Run Volume "default" "Master" ["-t", "<fc=#6c71c4>\xfc1d </fc><volume>%"] 10
        , Run Battery ["-t", "<fc=#268bd2><acstatus> </fc><left>%", "--", "-O", "\xf583","-o", "\xf57f"] 60
        , Run Date "<fc=#859900>\xf133 </fc>%d.%m.%Y %H:%M" "date" 60
        , Run StdinReader
        ]
    , sepChar = "%"
    , alignSep = "}{"
    , template = " %StdinReader%}{%cpu%|%memory% %swap%|%wlp11s0%|%default:Master%|%battery%|%date% "
    }
