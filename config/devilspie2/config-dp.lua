------------------------------------------------------------------
-- My Devilspie2 configuration for (almos) any resolution
-- My setup consists of two monitors, top and bottom
-- I only use workspaces on primary (top) screen
--
-- github.com/lu0
--
-- Use "devilspie2 --debug" to print to stdout
-- link/copy dotfiles_linuxMint/scripts/display_info.sh 
-- to PATH as display_info
---------------------------------------------------------------------

local socket = require 'socket'
-- socket.sleep(0.2)                 -- wait for the window to open

local sh = require('sh')        -- module developed by https://github.com/zserge/luash
-- local mousemove = sh.command('xdotool mousemove')
-- mousemove(500, 100)

-- Unpack variables from display_info.sh
i = 0
local screen_variables = tostring(display_info()) -- calls `ls /tmp`
for var in string.gmatch(screen_variables, "[^\n]+") do
    if     i == 0 then MONITOR    = var;   print('MONITOR: ',    MONITOR)        -- str
    elseif i == 1 then RESOLUTION = var;   -- print('RESOLUTION: ', RESOLUTION)     -- str 
    elseif i == 2 then X_OFFSET   = var+0; -- print('X_OFFSET: ',   X_OFFSET)       -- num
    elseif i == 3 then Y_OFFSET   = var+0; -- print('Y_OFFSET: ',   Y_OFFSET)       -- num
    elseif i == 4 then WIDTH      = var+0; -- print('WIDTH: ',      WIDTH)          -- num
    elseif i == 5 then HEIGHT     = var+0; -- print('HEIGHT: ',     HEIGHT)         -- num
    elseif i == 6 then WINDOW_ID  = var+0; -- print('WINDOW_ID: ',  WINDOW_ID)      -- num
    end
    i = i + 1
end

if (Y_OFFSET > 0) then screen = "BOTTOM"
else                   screen = "TOP"
end

panel_width = 36    -- vertical panel
gap = math.floor(WIDTH/192 * 10) / 10
x_gap = gap; y_gap = gap
gnome_fix = WIDTH/960

debug_print("Active screen: ", MONITOR .. ',', screen)
debug_print("\nWindow ID: ", WINDOW_ID)
debug_print("Window type: ", get_window_type())
debug_print("Window Name: ", get_window_name())
debug_print("App name: ", get_application_name())
debug_print("Class name: ", get_class_instance_name())

-- Maximize with gaps
-- Screenshot and zenity apps don't resize correctly
if (string.match(get_window_type(), "NORMAL") and 
    get_application_name() ~= "Screenshot" and
    get_application_name() ~= "zenity") then

    set_on_top();
    focus();
    
    -- if (get_application_name() ~= "Screenshot") then
    set_window_geometry2(x_gap + panel_width - gnome_fix + X_OFFSET,    y_gap - gnome_fix + Y_OFFSET, 
                         WIDTH - panel_width - x_gap*gnome_fix,         HEIGHT-y_gap*gnome_fix);
    -- end
    debug_print("NOT DIALOG")

elseif (string.match(get_window_type(), "SPLASH")) then
    x, y, w, h = get_window_geometry()
    set_window_geometry2(x+X_OFFSET, y+Y_OFFSET, w, h);
    debug_print("DIALOG")
    -- debug_print(X_OFFSET)
    -- debug_print(Y_OFFSET)
    -- debug_print(x)
    -- debug_print(y)
    -- debug_print(w)
    -- debug_print(h)
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
    
    ink_w = WIDTH/5.5;  ink_h = HEIGHT/1.25
    ink_x = WIDTH/1.32; ink_y = HEIGHT/8.9

    set_window_geometry2(ink_x+X_OFFSET, ink_y+Y_OFFSET, ink_w, ink_h)
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

-- Keep 'picture in picture' on top.
if (string.match(get_application_name(), "Picture in picture")) then
    make_always_on_top()
end