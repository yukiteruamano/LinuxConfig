--[[
    Frost Awesome WM 3.5.x
    Arc Theme eye-candy for Awesome
--]]


theme                               = {}

theme.confdir                       = os.getenv("HOME") .. "/.config/awesome/themes/frost"

theme.font                          = "Terminus 8"
theme.taglist_font                  = "Terminus 8"
theme.bg_normal                     = "#2f343f"
theme.bg_focus                      = "#2f343f"
theme.bg_urgent                     = "#434c56"
theme.bg_minimize                   = "#2f343f"
theme.fg_normal                     = "#ffffff"
theme.fg_focus                      = "#5294E2"
theme.fg_urgent                     = "#ffffff"
theme.fg_minimize                   = "#ffffff"
theme.fg_black                      = "#00264d"
theme.fg_red                        = "#ff0000"
theme.fg_green                      = "#009999"
theme.fg_yellow                     = "#ffff00"
theme.fg_blue                       = "#5294e2"
theme.fg_magenta                    = "#F50087"
theme.fg_cyan                       = "#00FFFF"
theme.fg_white                      = "#ffffff"
theme.fg_blu                        = "#5294e2"
theme.border_width                  = "1"
theme.border_normal                 = "#434c56"
theme.border_focus                  = "#434c56"
theme.border_marked                 = "#434c56"
theme.menu_width                    = "120"
theme.menu_border_width             = "1"
theme.menu_fg_normal                = "#ffffff"
theme.menu_fg_focus                 = "#ffffff"
theme.menu_bg_normal                = "#2f343f"
theme.menu_bg_focus                 = "#5294e2"

theme.submenu_icon                  = theme.confdir .. "/icons/submenu.png"
theme.widget_temp                   = theme.confdir .. "/icons/temp.png"
theme.widget_uptime                 = theme.confdir .. "/icons/ac.png"
theme.widget_cpu                    = theme.confdir .. "/icons/cpu.png"
theme.widget_weather                = theme.confdir .. "/icons/dish.png"
theme.widget_fs                     = theme.confdir .. "/icons/fs.png"
theme.widget_mem                    = theme.confdir .. "/icons/mem.png"
theme.widget_fs                     = theme.confdir .. "/icons/fs.png"
theme.widget_note                   = theme.confdir .. "/icons/note.png"
theme.widget_note_on                = theme.confdir .. "/icons/note_on.png"
--theme.widget_netdown                = theme.confdir .. "/icons/net_down.png"
--theme.widget_netup                  = theme.confdir .. "/icons/net_up.png"
theme.widget_mail                   = theme.confdir .. "/icons/mail.png"
theme.widget_batt                   = theme.confdir .. "/icons/bat.png"
theme.widget_clock                  = theme.confdir .. "/icons/clock.png"
theme.widget_vol                    = theme.confdir .. "/icons/spkr.png"

theme.taglist_squares_sel           = theme.confdir .. "/icons/square_a.png"
theme.taglist_squares_unsel         = theme.confdir .. "/icons/square_b.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

theme.layout_tile                   = theme.confdir .. "/icons/tile.png"
theme.layout_tilegaps               = theme.confdir .. "/icons/tilegaps.png"
theme.layout_tileleft               = theme.confdir .. "/icons/tileleft.png"
theme.layout_tilebottom             = theme.confdir .. "/icons/tilebottom.png"
theme.layout_tiletop                = theme.confdir .. "/icons/tiletop.png"
theme.layout_fairv                  = theme.confdir .. "/icons/fairv.png"
theme.layout_fairh                  = theme.confdir .. "/icons/fairh.png"
theme.layout_spiral                 = theme.confdir .. "/icons/spiral.png"
theme.layout_dwindle                = theme.confdir .. "/icons/dwindle.png"
theme.layout_max                    = theme.confdir .. "/icons/max.png"
theme.layout_fullscreen             = theme.confdir .. "/icons/fullscreen.png"
theme.layout_magnifier              = theme.confdir .. "/icons/magnifier.png"
theme.layout_floating               = theme.confdir .. "/icons/floating.png"

return theme
