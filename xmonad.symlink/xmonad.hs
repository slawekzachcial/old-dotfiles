--
-- Sample configuration file based on article at http://www.linuxandlife.com/2011/11/how-to-configure-xmonad-arch-linux.html
--

import XMonad
import XMonad.Layout.Spacing
import XMonad.Layout.GridVariants
import XMonad.Layout.Renamed
import XMonad.Util.EZConfig
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import System.IO
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoFrillsDecoration

import XMonad.Prompt
import qualified XMonad.StackSet as W
import XMonad.Actions.DynamicWorkspaces
import qualified Data.Map as M


myLayout = renamed [CutWordsLeft 2] $ spacing 30 $ tiled ||| Grid(4/3) ||| Mirror tiled ||| Full
    where
        -- default tiling algorithm partitions the screen into two panes
        tiled = Tall nmaster delta ratio

        -- The default number of windows in the master pane
        nmaster = 1

        -- Default proportion of screen occupied by master pane
        ratio = 2/3

        -- Percent of screen to increment by when resizing panes
        delta = 5/100


myKeys conf@(XConfig {XMonad.modMask = mod4Mask}) = M.fromList $
    [ ((mod4Mask, xK_n), sendMessage Expand) -- map mod-n to expand as mod-l locks windows in VirtualBox
    , ((mod4Mask, xK_l), return ()) -- disable mod-l
--    , ((mod4Mask, xK_r), renameWorkspace defaultXPConfig)
--    , ((mod4Mask, xK_w), selectWorkspace defaultXPConfig)
--    , ((mod4Mask, xK_BackSpace), removeWorkspace)
    , ((mod4Mask, xK_b), sendMessage ToggleStruts) -- 0.12 issue with top spacing on WS 1 (https://github.com/xmonad/xmonad/issues/15)
    ]
    ++
    zip (zip (repeat (mod4Mask)) [xK_1..xK_9]) (map (withNthWorkspace W.greedyView) [0..])
    ++
    zip (zip (repeat (mod4Mask .|. shiftMask)) [xK_1..xK_9]) (map (withNthWorkspace W.shift) [0..])


main = do
    xmproc <- spawnPipe "/usr/bin/xmobar /home/slawek/.xmonad/xmobarrc"
    xmonad $ defaultConfig
        { modMask = mod4Mask
        , terminal = "termite"
        , borderWidth = 5
        , normalBorderColor = "#1793D1"
        , focusedBorderColor = "#FFA300"
        , layoutHook = noFrillsDeco shrinkText defaultTheme $ avoidStruts $ myLayout
        , manageHook = manageDocks <+> manageHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "#0FC4E3" "" . shorten 250
            , ppCurrent = xmobarColor "#FFA300" "" . wrap "[" "]"
            }
        , startupHook = setWMName "LG3D" -- needed by Java/Swing apps like Intellij
        , keys = myKeys <+> keys defaultConfig
        }

