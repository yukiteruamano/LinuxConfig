--[[
                                      
     Multicolor Awesome WM config 2.0 
     github.com/copycat-killer        
                                      
--]]


theme                               = {}

theme.confdir                       = os.getenv("HOME") .. "/.config/awesome/themes/personal"
--theme.wallpaper                     = theme.confdir .. "/wall.png"

theme.font                          = "Terminus 8"
theme.taglist_font					= "Terminus 8"
theme.bg_normal                     = "#2d2d2d"
theme.bg_focus                      = "#2d2d2d"
theme.bg_urgent                     = "#2d2d2d"
theme.bg_minimize                   = "#2d2d2d"
theme.fg_normal                     = "#f9f9f9"
theme.fg_focus                      = "#d64937"
theme.fg_urgent                     = "#d64937"
theme.fg_minimize                   = "#f9f9f9"
theme.fg_black                      = "#2d2d2d"
theme.fg_red                        = "#ce5666"
theme.fg_green                      = "#80a673"
theme.fg_yellow                     = "#ffaf5f"
theme.fg_blue                       = "#7788af"
theme.fg_magenta                    = "#94738c"
theme.fg_cyan                       = "#778baf"
theme.fg_white                      = "#f9f9f9"
theme.fg_blu                        = "#8ebdde"
theme.border_width                  = "1"
theme.border_normal                 = "#2d2d2d"
theme.border_focus                  = "#3d3d3d"
theme.border_marked                 = "#2d2d2d"
theme.menu_width                    = "100"
theme.menu_border_width             = "1"
theme.menu_fg_normal                = "#f9f9f9"
theme.menu_fg_focus                 = "#f9f9f9"
theme.menu_bg_normal                = "#2d2d2d"
theme.menu_bg_focus                 = "#d64937"

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
theme.widget_netdown                = theme.confdir .. "/icons/net_down.png"
theme.widget_netup                  = theme.confdir .. "/icons/net_up.png"
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
