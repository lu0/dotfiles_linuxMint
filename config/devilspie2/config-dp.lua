------------------------------------------------------------------
-- My Devilspie2 configuration for 1920x1080 resolutions
-- github.com/lu0
--
-- Use "devilspie2 --debug" to print to stdout
------------------------------------------------------------------
debug_print("Window type: " .. get_window_type())
debug_print("Window Name: " .. get_window_name());
debug_print("Application name: " .. get_application_name())
debug_print("Class: " .. get_class_instance_name())

-- Need something to retrieve position of cursor
-- or the position of the window before setting its new position
-- but this is not working :/
-- x, y = xy()
-- if (y < 1080) then
--     fix_y = 0
-- else
--     fix_y = 1080
-- end

-- Maximize with gaps
if (get_window_type() == "WINDOW_TYPE_NORMAL") then
    set_on_top();
    focus();
    -- set_window_geometry2(46-2, 10-2+fix_y, 1864, 1060);
    set_window_geometry2(46-2, 10-2, 1864, 1060);
end

if (get_window_type() == "WINDOW_TYPE_DIALOG") then
    set_on_top();
    focus();
    -- center();
--     if (not string.match(get_class_instance_name(), "gnome")) then
--         debug_print("Not a Gnome dialog");
--         -- Set default dimensions of dialogs
--         -- Except for gnome apps (they act weird..)
--         set_window_geometry2(265-12, 90-12, 1454, 925);
--     end
end

-- Workspace 2. I use it for graphic design
if (get_class_instance_name()=="inkscape" or get_class_instance_name()=="krita") then
    pin_window()
    set_window_workspace(2);
    change_workspace(2);
    -- Inkscape dialog windows are of type "NORMAL", but aren't name as "Inkscape"
    if (get_class_instance_name()~="krita" and 
        not string.match(get_window_name(), "- Inkscape")) then
        -- Move floating inkscape dialogs to the right 
        set_window_geometry2(1453, 121, 361, 866);
    end
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

-- Workspace 5. System workspace
-- if (get_application_name()=="cinnamon-settings.py") then
--     set_window_geometry(44, 8, 1864, 1060);
--     set_window_workspace(5);
--     change_workspace(5);
-- end

-- Workspace 7. Gaming workspace
if (get_class_instance_name()=="Steam") then
    set_window_workspace(7);
    change_workspace(7);
end

-- Workspace 8. Media
if (get_application_name()=="Spotify" or 
    -- get_application_name()=="pavucontrol" or
    -- get_class_instance_name()=="cinnamon-settings sound" or
    -- get_application_name()=="blueman-manager" or
    get_class_instance_name()=="audacity" or
    get_class_instance_name()=="kdenlive") then
    set_window_workspace(8);
    change_workspace(8);
end