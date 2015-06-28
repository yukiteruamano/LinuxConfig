--[[
    Theme Numix for YukiteruAmano
--]]

-- {{{ Required libraries
local gears     = require("gears")
local awful     = require("awful")
awful.rules     = require("awful.rules")
                  require("awful.autofocus")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local drop      = require("scratchdrop")
local lain      = require("lain")

-- }}}

-- {{{ Error handling
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Autostart applications
function run_once(cmd)
    findme = cmd
    firstspace = cmd:find(" ")
    if firstspace then
        findme = cmd:sub(0, firstspace-1)
    end
    awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

run_once("urxvtd")
run_once("mpd")
run_once("setxkbmap es")
run_once("nitrogen --restore")
run_once("parcellite")
run_once("compton --config .config/compton/compton.conf")
run_once("unclutter -root")
-- }}}

-- {{{ Variable definitions

-- beautiful init
beautiful.init(os.getenv("HOME") .. "/.config/awesome/themes/personal/theme.lua")

-- common
modkey     = "Mod4"
altkey     = "Mod1"
terminal   = "urxvtc"
editor     = os.getenv("EDITOR") or "nano" or "vim"
editor_cmd = terminal .. " -e " .. editor

-- user defined
browser         = "firefox"
gui_editor      = "geany"
dev_editor      = terminal .. " -e vim"
audio_ncmpcpp   = terminal .. " -e ncmpcpp"
graphics        = "gimp"
mail            = "thunderbird"
file_manager    = "spacefm"
audio_mixer     = "pavucontrol"
irc_client      = terminal .. " -e weechat-curses"

local layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.tile.bottom,
}
-- }}}

-- {{{ Tags

tags = {
    names = { "web", "irc", "term" ,"files", "dev", "others" },
    layout = { layouts[6], layouts[7], layouts[4], layouts[4], layouts[4], layouts[1] }
}
for s = 1, screen.count() do
   tags[s] = awful.tag(tags.names, s, tags.layout)
end

-- }}}

-- {{{ Menu

myawesomemenu = {
{"edit config", terminal .. " -e vim /home/yukiteru/.config/awesome/rc.lua"},
{"restart wm", awesome.restart },
{"reboot", terminal .. " -e su -c 'reboot'"},
{"shutdown", terminal .. " -e su -c 'shutdown -h now'"},
{"quit", awesome.quit }
}
mygamesmenu = {
{" Steam", "steam"},
{" Mupen64Plus", "mupen64plus"},
{" Xonotic", "xonotic-glx"}
}
mydevmenu = {
{" Geany", "geany"},
{" Vim", terminal .. " -e vim"},
{" Meld", "meld"},
{" Docs", "spacefm /home/yukiteru/Programacion/Docs"},
{" Dev Directory",  "spacefm /home/yukiteru/Programacion"}
}
mygraphicsmenu = {
{" Gimp", "gimp"},
{" Nitrogen", "nitrogen"},
{" Viewnior", "viewnior" }
}
mymultimediamenu = {
{" ncmpcpp", terminal .. " -e ncmpcpp"},
{" Audacity", "audacity"},
{" XFBurn", "xfburn"}
}
myofficemenu = {
{" Base", "libreoffice --base"},
{" Calc", "libreoffice --calc"},
{" Draw", "libreoffice --draw"},
{" Impress", "libreoffice --impress"},
{" Math", "libreoffice --math"},
{" Writer", "libreoffice --writer"},
{" Zathura", "zathura",},
{" FBReader", "fbreader",},
{" My Books", "spacefm /mnt/DD250GB/Biblioteca"}
}
mywebmenu = {
{" Filezilla", "filezilla"},
{" Firefox", "firefox"},
{" Thunderbird", "thunderbird"},
{" Gajim", "gajim"},
{" Telegram", "telegram"},
{" JDownloader", "java -jar /home/yukiteru/.jd2/JDownloader.jar"},
{" Transmission", "transmission-daemon"},
{" Weechat", terminal .. " -e weechat-curses"}
}
mysettingsmenu = {
{" Flash Player", "flash-player-properties"},
{" lxappearance ", "lxappearance"}
}
mytoolsmenu = {
{" virt-manager", "virt-manager"},
{" File-Roller", "file-roller"}
}
mymainmenu = awful.menu({ items = {
{ " @wesome", myawesomemenu},
{" development", mydevmenu},
{" games", mygamesmenu},
{" graphics", mygraphicsmenu},
{" multimedia", mymultimediamenu},
{" office", myofficemenu},
{" tools", mytoolsmenu},
{" web", mywebmenu},
{" settings", mysettingsmenu},
{" htop", terminal .. " -e htop"},
{" lock", "slimlock"}
}
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                    menu = mymainmenu })

-- }}}

-- {{{ Wibox
markup      = lain.util.markup

-- Clock
clockicon = wibox.widget.imagebox(beautiful.widget_clock)
mytextclock = lain.widgets.abase({
    timeout  = 60,
    cmd      = "date +'%A %d %B %R'",
    settings = function()
        local t_output = ""
        local o_it = string.gmatch(output, "%S+")

        for i=1,3 do t_output = t_output .. " " .. o_it(i) end

        widget:set_markup(markup("#d64937", t_output) .. markup("#d64937", " - ") .. markup("#f9f9f9", o_it(1)) .. " ")
    end
})

-- Calendar
lain.widgets.calendar:attach(mytextclock, { font_size = 10 })

-- Filesystems
fsicon = wibox.widget.imagebox(beautiful.widget_fs)
fswidget = lain.widgets.fs({
    settings  = function()
        widget:set_markup(markup("#f9f9f9", fs_now.used .. "% "))
    end
})

-- CPU
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)
cpuwidget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(markup("#f9f9f9", cpu_now.usage .. "% "))
    end
})


-- Coretemp
tempicon = wibox.widget.imagebox(beautiful.widget_temp)
tempwidget = lain.widgets.temp({
    settings = function()
        widget:set_markup(markup("#f9f9f9", coretemp_now .. "°C "))
    end
})

-- ALSA volume
volicon = wibox.widget.imagebox(beautiful.widget_vol)
volumewidget = lain.widgets.alsa({
    settings = function()
        if volume_now.status == "off" then
            volume_now.level = volume_now.level .. "M"
        end

        widget:set_markup(markup("#f9f9f9", volume_now.level .. "% "))
    end
})

-- Net
netdownicon = wibox.widget.imagebox(beautiful.widget_netdown)
netdowninfo = wibox.widget.textbox()
netupicon = wibox.widget.imagebox(beautiful.widget_netup)
netupinfo = lain.widgets.net({
    settings = function()
        widget:set_markup(markup("#f9f9f9", net_now.sent .. " "))
        netdowninfo:set_markup(markup("#f9f9f9", net_now.received .. " "))
    end
})

-- MEM
memicon = wibox.widget.imagebox(beautiful.widget_mem)
memwidget = lain.widgets.mem({
    settings = function()
        widget:set_markup(markup("#f9f9f9", mem_now.used .. "M "))
    end
})

-- MPD
mpdicon = wibox.widget.imagebox()
mpdwidget = lain.widgets.mpd({
    settings = function()
        mpd_notification_preset = {
            text = string.format("%s [%s] - %s\n%s", mpd_now.artist,
                   mpd_now.album, mpd_now.date, mpd_now.title)
        }
        if mpd_now.state == "play" then
            artist = mpd_now.artist .. " > "
            title  = mpd_now.title .. " "
            mpdicon:set_image(beautiful.widget_note_on)
        elseif mpd_now.state == "pause" then
            artist = "mpd "
            title  = "paused "
        else
            artist = ""
            title  = ""
            mpdicon:set_image(nil)
        end
        widget:set_markup(markup("#d64937", artist) .. markup("#f9f9f9", title))
    end
})

-- Spacer
spacer = wibox.widget.textbox(" ")

-- }}}

-- {{{ Layout

-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do

    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()

    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                            awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                            awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the upper wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 20, border_width = 0 })

    -- Widgets that are aligned to the upper left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the upper right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mpdicon)
    right_layout:add(mpdwidget)
    right_layout:add(netdownicon)
    right_layout:add(netdowninfo)
    right_layout:add(netupicon)
    right_layout:add(netupinfo)
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    right_layout:add(memicon)
    right_layout:add(memwidget)
    right_layout:add(cpuicon)
    right_layout:add(cpuwidget)
    right_layout:add(fsicon)
    right_layout:add(fswidget)
    right_layout:add(tempicon)
    right_layout:add(tempwidget)
    right_layout:add(clockicon)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)

end
-- }}}


-- {{{ Mouse Bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Take a screenshot
    awful.key({ altkey }, "p", function() os.execute("scrot -e 'mv $f /home/yukiteru/Imágenes/Screenfetch/'") end),

    -- Tag browsing
    awful.key({ modkey }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey }, "Escape", awful.tag.history.restore),

    -- Non-empty tag browsing
    awful.key({ altkey }, "Left", function () lain.util.tag_view_nonempty(-1) end),
    awful.key({ altkey }, "Right", function () lain.util.tag_view_nonempty(1) end),

    -- Default client focus
    awful.key({ altkey }, "k",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ altkey }, "j",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- By direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.bydirection("down")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.bydirection("up")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end),

    -- Show Menu
    awful.key({ modkey }, "w",
        function ()
            mymainmenu:show({ keygrabber = true })
        end),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
        mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible
        mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible
    end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),
    awful.key({ altkey, "Shift"   }, "l",      function () awful.tag.incmwfact( 0.05)     end),
    awful.key({ altkey, "Shift"   }, "h",      function () awful.tag.incmwfact(-0.05)     end),
    awful.key({ modkey, "Shift"   }, "l",      function () awful.tag.incnmaster(-1)       end),
    awful.key({ modkey, "Shift"   }, "h",      function () awful.tag.incnmaster( 1)       end),
    awful.key({ modkey, "Control" }, "l",      function () awful.tag.incncol(-1)          end),
    awful.key({ modkey, "Control" }, "h",      function () awful.tag.incncol( 1)          end),
    awful.key({ modkey,           }, "space",  function () awful.layout.inc(layouts,  1)  end),
    awful.key({ modkey, "Shift"   }, "space",  function () awful.layout.inc(layouts, -1)  end),
    awful.key({ modkey, "Control" }, "n",      awful.client.restore),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r",      awesome.restart),
    awful.key({ modkey, "Shift"   }, "q",      awesome.quit),

    -- Dropdown terminal
    -- awful.key({ modkey,	          }, "z",      function () drop(terminal) end),

    -- Widgets popups
    awful.key({ altkey,           }, "c",      function () lain.widgets.calendar:show(7) end),
    awful.key({ altkey,           }, "h",      function () fswidget.show(7) end),

    -- ALSA volume control
    awful.key({ altkey }, "Up",
        function ()
            os.execute(string.format("amixer -c %s set %s 1+", volumewidget.card, volumewidget.channel))
            volumewidget.update()
        end),
    awful.key({ altkey }, "Down",
        function ()
            os.execute(string.format("amixer -c %s set %s 1-", volumewidget.card, volumewidget.channel))
            volumewidget.update()
        end),
    awful.key({ altkey }, "m",
        function ()
            os.execute(string.format("amixer -c %s set %s toggle", volumewidget.card, volumewidget.channel))
            volumewidget.update()
        end),
    awful.key({ altkey, "Control" }, "m",
        function ()
            os.execute(string.format("amixer -c %s set %s 100%%", volumewidget.card, volumewidget.channel))
            volumewidget.update()
        end),

    -- MPD control
    awful.key({ altkey, "Control" }, "Up",
        function ()
            awful.util.spawn_with_shell("mpc toggle")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Down",
        function ()
            awful.util.spawn_with_shell("mpc stop")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Left",
        function ()
            awful.util.spawn_with_shell("mpc prev")
            mpdwidget.update()
        end),
    awful.key({ altkey, "Control" }, "Right",
        function ()
            awful.util.spawn_with_shell("mpc next")
            mpdwidget.update()
        end),

    -- Copy to clipboard
    awful.key({ modkey }, "c", function () os.execute("xsel -p -o | xsel -i -b") end),
    awful.key({ modkey, altkey }, "f", function () awful.util.spawn(browser) end),
    awful.key({ modkey, altkey }, "m", function () awful.util.spawn(mail) end),
    awful.key({ modkey, altkey }, "g", function () awful.util.spawn(graphics) end),
    awful.key({ modkey, altkey }, "s", function () awful.util.spawn(file_manager) end),
    awful.key({ modkey, altkey }, "n", function () awful.util.spawn(audio_ncmpcpp) end),
    awful.key({ modkey, altkey }, "v", function () awful.util.spawn(dev_editor) end),
    awful.key({ modkey, altkey }, "p", function () awful.util.spawn(audio_mixer) end),
    awful.key({ modkey, altkey }, "e", function () awful.util.spawn(gui_editor) end),
    awful.key({ modkey, altkey }, "i", function () awful.util.spawn(irc_client) end),

    -- Prompt
    awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Bind all key numbers to tags.
-- be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                     end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- Vain Layouts

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
        properties = { border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            keys = clientkeys,
            buttons = clientbuttons,
            size_hints_honor = false
        }
    },

    { rule = { class = "Xonotic" },
        properties = { tag = tags[1][6]}
    },

    { rule = { class = "Gajim" },
        properties = { tag = tags[1][2] }
    },

    { rule = { class = "Xfburn" },
        properties = { tag = tags[1][6] }
    },

    { rule = { class = "Filezilla" },
        properties = { tag = tags[1][4] }
    },

    { rule = { class = "pinentry", name = "pinentry" },
        properties = { floating = true },
    },

    { rule = { class = "Pinentry-gtk-2", name = "pinentry-gtk-2" },
        properties = { floating = true },
    },

    { rule = { class = "Firefox"},
        properties = { tag = tags[1][1] }
    },

    { rule = { class = "plugin-container"},
        properties = { floating = true }
    },

    { rule = { class = "Firefox" , instance = "DTA" },
        properties = { tag = tags[1][1], floating = true },
            callback = function (c)
            awful.placement.centered(c,nil)
        end
    },

    { rule = { class = "Firefox" , instance = "Toplevel" },
        properties = { tag = tags[1][1], floating = true },
        callback = function (c)
            awful.placement.centered(c,nil)
        end
    },

    { rule = { class = "Firefox" , instance = "Preferencias de Firefox" },
        properties = { tag = tags[1][1], floating = true },
        callback = function (c)
            awful.placement.centered(c,nil)
        end
    },

    { rule = { class = "Firefox" , instance = "Browser" },
        properties = { tag = tags[1][1], floating = true },
        callback = function (c)
            awful.placement.centered(c,nil)
        end
    },

    { rule = { class = "Firefox" , name = "Contraseñas guardadas" },
        properties = { tag = tags[1][1], floating = true },
        callback = function (c)
            awful.placement.centered(c,nil)
        end
    },

    { rule = { class = "Firefox" , instance = "Descargas" },
        properties = { tag = tags[1][1], floating = true },
        callback = function (c)
            awful.placement.centered(c,nil)
        end
    },

    { rule = { class = "Firefox" , instance = "Catálogo" },
        properties = { tag = tags[1][1], floating = true },
        callback = function (c)
            awful.placement.centered(c,nil)
        end
    },

    { rule = { class = "Firefox" , name = "Install user style" },
        properties = { tag = tags[1][1], floating = true },
        callback = function (c)
            awful.placement.centered(c,nil)
        end
    },

    { rule = { class = "Thunderbird"},
        properties = { tag = tags[1][1] }
    },

    { rule = { class = "Geany", name = "Geany" },
        properties = { tag = tags[1][5] }
    },

    { rule = { class = "Meld" },
        properties = { tag = tags[1][5] }
    },

    { rule = { class = "Gimp" },
        properties = { tag = tags[1][6] }
    },

    { rule = { class = "Gimp", role = "gimp-image-window" },
        properties = { maximized_horizontal = true,
            maximized_vertical = true
        }
    },

    { rule = { class = "Spacefm" },
         properties = { tag = tags[1][4] }
    },

    { rule = { name = "Gestor de archivadores" },
        properties = { tag = tags[1][4] }
    },

    { rule = { name = "Gestor de máquinas virtuales" },
        properties = { tag = tags[1][6] }
    },

    { rule = { class = "Steam" },
        properties = { tag = tags[1][6] }
    },

    { rule = { class = "libreoffice-impress" },
        properties = { tag = tags[1][6] }
    },

    { rule = { class = "libreoffice-math" },
        properties = { tag = tags[1][6] }
    },

    { rule = { class = "libreoffice-calc" },
        properties = { tag = tags[1][6] }
    },

    { rule = { class = "libreoffice-writer" },
        properties = { tag = tags[1][6] }
    },

    { rule = { class = "libreoffice-base" },
        properties = { tag = tags[1][6] }
    },

    { rule = { class = "libreoffice-draw" },
        properties = { tag = tags[1][6] }
    },

    { rule = { class = "Audacity" },
        properties = { tag = tags[1][6] }
    },

    { rule = { name = "Mupen64Plus v1.5" },
        properties = { tag = tags[1][6] }
    },

    { rule = { class = "URxvt" },
        properties = { opacity = 0.90, tag = tags[1][3] }
    },

    { rule = { class = "URxvt", name = "ncmpcpp"},
        properties = { floating = true},
            callback = function (c)
            current_tag = tags[mouse.screen][awful.tag.getidx()]
            tag = current_tag
            awful.client.movetotag(tag, c)
        end
    },

    { rule = { class = "URxvt", name = "htop"},
        properties = { floating = true },
            callback = function (c)
            current_tag = tags[mouse.screen][awful.tag.getidx()]
            tag = current_tag
            awful.client.movetotag(tag, c)
        end
    },

    { rule = { class = "URxvt", name = "vim" },
        properties = { tag = tags[1][5] }
    },

    { rule = { class = "URxvt", name = "weechat" },
        properties = { tag = tags[1][2] }
    },

    { rule = { class = "Telegram"},
        properties = { tag = tags[1][2] }
    },

    { rule = { class = "JDownloader 2 BETA", name = "JDownloader 2 BETA" },
        properties = { tag = tags[1][1]}
    },
}

-- }}}

-- {{{ Signals
-- signal function to execute when a new client appears.
local sloppyfocus_last = { c = nil }
    client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    client.connect_signal("mouse::enter", function(c)
         if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
             -- Skip focusing the client if the mouse wasn't moved.
             if c ~= sloppyfocus_last.c then
                 client.focus = c
                 sloppyfocus_last.c = c
             end
         end
     end)

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )
        -- widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- the title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c,{size=16}):set_widget(layout)
    end
end)

-- No border for maximized clients
client.connect_signal("focus",
    function(c)
        if c.maximized_horizontal == true and c.maximized_vertical == true then
            c.border_color = beautiful.border_normal
        else
            c.border_color = beautiful.border_focus
        end
    end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Arrange signal handler
for s = 1, screen.count() do screen[s]:connect_signal("arrange", function ()
        local clients = awful.client.visible(s)
        local layout  = awful.layout.getname(awful.layout.get(s))

        if #clients > 0 then -- Fine grained borders and floaters control
            for _, c in pairs(clients) do -- Floaters always have borders
                -- No borders with only one humanly visible client
                if layout == "max" then
                    c.border_width = 0
                elseif awful.client.floating.get(c) or layout == "floating" then
                    c.border_width = beautiful.border_width
                elseif #clients == 1 then
                    clients[1].border_width = 0
                    if layout ~= "max" then
                        awful.client.moveresize(0, 0, 2, 0, clients[1])
                    end
                else
                    c.border_width = beautiful.border_width
                end
            end
        end
      end)
end
-- }}}
