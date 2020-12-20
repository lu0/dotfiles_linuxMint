------------------------------------------------------------------
-- My Devilspie2 configuration for 1920x1080 resolutions
-- My setup consists of two monitors, top and bottom
-- I only use workspaces on active (top) screen
--
-- github.com/lu0
--
-- Use "devilspie2 --debug" to print to stdout
------------------------------------------------------------------

local socket = require 'socket'
socket.sleep(0.2)                 -- wait for the window to open

local sh = require('sh')        -- module developed by https://github.com/zserge/luash
local get_mouse_loc = sh.command('xdotool getmouselocation --shell')
-- local mousemove = sh.command('xdotool mousemove')
-- mousemove(500, 100)

-- pipe using sh
x = get_mouse_loc():grep("X"):cut('-d', "=", '-f', 2)
y = get_mouse_loc():grep("Y"):cut('-d', "=", '-f', 2)
x = tonumber(tostring(x))
y = tonumber(tostring(y))

debug_print("Window type: " .. get_window_type())
debug_print("Window Name: " .. get_window_name())
debug_print("Application name: " .. get_application_name())
debug_print("Class: " .. get_class_instance_name())
debug_print("Mouse position: x=" .. x .. " y=" .. y)

top_screen_height = 1080                    -- FHD
if (y > top_screen_height) then
    fix_y = top_screen_height
    screen = "BOTTOM"
else
    fix_y = 0
    screen = "TOP"
end
debug_print("Active screen: " .. screen)

-- Maximize with gaps
if (string.match(get_window_type(), "NORMAL")) then
    set_on_top();
    focus();

    -- Screenshot app does not resize correctly
    if (get_application_name() ~= "Screenshot") then
        set_window_geometry2(46-2, 10-2+fix_y, 1864, 1060);
    end
    debug_print("NOT DIALOG")

elseif (string.match(get_window_type(), "SPLASH")) then
    x, y, w, h = get_window_geometry()
    set_window_geometry2(x, y+fix_y, w, h);
    debug_print("DIALOG")
    debug_print(fix_y)
    debug_print(x)
    debug_print(y)
    debug_print(w)
    debug_print(h)
end

-- if (get_window_type() == "WINDOW_TYPE_DIALOG") then
--     set_on_top();
--     focus();
--     -- center();
-- --     if (not string.match(get_class_instance_name(), "gnome")) then
-- --         debug_print("Not a Gnome dialog");
-- --         -- Set default dimensions of dialogs
-- --         -- Except for gnome apps (they act weird..)
-- --         set_window_geometry2(265-12, 90-12, 1454, 925);
-- --     end
-- end

-- Resize Inkscape dialogs
if (string.match(get_application_name(), "inkscape") and
    get_window_type() == "WINDOW_TYPE_DIALOG") then
    -- Move to the bottom
    set_window_geometry2(1453, 121+fix_y, 361, 866)
end

if (screen=="TOP") then

    -- Workspace 2. I use it for graphic design
    if (string.match(get_application_name(), "inkscape") or 
        string.match(get_application_name(), "Krita")) then

        pin_window()
        set_window_workspace(2)
        change_workspace(2)
    end

    -- Workspace 3. Productivity programs I use
    if (get_class_instance_name()=="Visual Studio Code" or
        get_application_name()=="DesktopEditors") then
        set_window_workspace(3);
        change_workspace(3);
    end

    -- Workspace 4. File explorer
    if (get_application_name()=="nemo") then
        set_window_workspace(4);
        change_workspace(4);
    end

    -- Workspace 7. Gaming workspace
    if (get_class_instance_name()=="Steam") then
        set_window_workspace(7);
        change_workspace(7);
    end

    -- Workspace 8. Media
    if (get_application_name()=="Spotify" or 
        get_class_instance_name()=="audacity" or
        get_class_instance_name()=="kdenlive") then
        set_window_workspace(8);
        change_workspace(8);
    end
end
