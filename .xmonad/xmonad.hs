--
-- xmonad example config file.
--

import XMonad
import Data.Monoid
import Graphics.X11.ExtraTypes.XF86
import System.Exit

import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.ManageDocks

import XMonad.Layout.LayoutModifier
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed

import XMonad.Util.Run
import XMonad.Util.SpawnOnce

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

myTerminal      = "alacritty"
myBrowser       = "brave-browser"
myDmenu         = "dmenu_run -fn 'JetBrains Mono-10' -nb '#000000' -nf '#ffffff' -sb '#ffffff' -sf '#000000'"
spotify         = "flatpak run com.spotify.Client"
discord         = "flatpak run com.discordapp.Discord"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

myModMask       = mod4Mask

myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows
myBorderWidth   = 2
myNormalBorderColor  = "#333333"
myFocusedBorderColor = "#666666"

------------------------------------------------------------------------

-- Key bindings. Add, modify or remove key bindings here.
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch terminal
    [ ((modm, xK_Return), spawn $ XMonad.terminal conf)

    -- launch browser
    , ((modm, xK_b), spawn myBrowser)

    -- launch discord
    , ((modm .|. shiftMask, xK_d), spawn discord)

    -- launch spotify
    , ((modm .|. shiftMask, xK_s), spawn spotify)

    -- launch dmenu
    , ((modm, xK_p), spawn myDmenu)

    -- close focused window
    , ((modm .|. shiftMask, xK_q), kill)

     -- Rotate through the available layout algorithms
    , ((modm, xK_space), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm, xK_n), refresh)

    -- Move focus to the next window
    , ((modm, xK_Tab), windows W.focusDown)

    -- Move focus to the next window
    , ((modm, xK_j), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm, xK_k), windows W.focusUp)

    -- Move focus to the master window
    , ((modm, xK_m), windows W.focusMaster)

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j), windows W.swapDown)

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k), windows W.swapUp)

    -- Shrink the master area
    , ((modm, xK_h), sendMessage Shrink)

    -- Expand the master area
    , ((modm, xK_l), sendMessage Expand)

    -- Push window back into tiling
    , ((modm, xK_t), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm, xK_comma), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm, xK_period), sendMessage (IncMasterN (-1)))

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_c), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm, xK_q), spawn "xmonad --recompile; xmonad --restart")

    -- Volume control
    , ((0, xF86XK_AudioMute), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ((0, xF86XK_AudioLowerVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%")
    , ((0, xF86XK_AudioRaiseVolume), spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%")

    -- Brightness control
    , ((0, xF86XK_MonBrightnessUp), spawn "lux -a 10%")
    , ((0, xF86XK_MonBrightnessDown), spawn "lux -s 10%")
    ]

    ++

    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

    ++

    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

------------------------------------------------------------------------

-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------

-- Layouts:

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

myTabConfig = def { activeColor = "#666666"
                  , inactiveColor = "#1d1f21"
                  , urgentColor = "#cc6666"
                  , activeBorderColor = "#666666"
                  , inactiveBorderColor = "#1d1f21"
                  , urgentBorderColor = "#cc6666"
                  , activeTextColor = "#ffffff"
                  , inactiveTextColor = "#969896"
                  , urgentTextColor = "#ffffff"
                  , fontName = "xft:JetBrains Mono:size=10:antialias=true:hinting=true"
                  }

myLayout = avoidStruts $ mySpacing 5 (tiled ||| tabbed shrinkText myTabConfig ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------

-- Window rules:

-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "Blueberry.py"   --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------

myEventHook = mempty

------------------------------------------------------------------------

myLogHook = return ()

------------------------------------------------------------------------

-- Startup hook
myStartupHook = do
    spawnOnce "feh --bg-scale $HOME/Pictures/wallpapers/daft_punk.png &"
    spawnOnce "compton &"

------------------------------------------------------------------------

-- Now run xmonad with all the defaults we set up.
-- Run xmonad with the settings you specify. No need to modify this.
main = do
    xmproc <- spawnPipe "xmobar -x 0 $HOME/.config/xmobar/xmobar.config"
    xmonad $ docks def {
        -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

        -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

        -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        startupHook        = myStartupHook,
        logHook            = myLogHook <+> dynamicLogWithPP xmobarPP
                                { ppOutput = \x -> hPutStrLn xmproc x
                                , ppCurrent = xmobarColor "#f0c674" "" . wrap "[" "]"
                                , ppVisible = xmobarColor "#ffffff" ""
                                , ppHidden = xmobarColor "#ffffff" "" . wrap "*" ""
                                , ppHiddenNoWindows = xmobarColor "#ffffff" ""
                                , ppTitle = xmobarColor "#f0c674" "" . shorten 60
                                , ppLayout = xmobarColor "#f0c674" ""
                                , ppSep =  "<fc=#666666> <fn=1>|</fn> </fc>"
                                , ppUrgent = xmobarColor "#cc6666" "" . wrap "!" "!"
                                , ppOrder  = \ (ws:l:t:ex) -> [ws,l]++ex++[t]
                        }
    }
