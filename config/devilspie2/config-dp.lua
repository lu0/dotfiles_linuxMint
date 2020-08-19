-- Use "devilspie2 --debug" to print to stdout
debug_print("Window type: " .. get_window_type())
debug_print("Window Name: " .. get_window_name());
debug_print("Application name: " .. get_application_name())
debug_print("Class: " .. get_class_instance_name())

if (get_window_type() == "WINDOW_TYPE_NORMAL") then
    set_on_top();
    focus();
    -- Maximize with gaps
    set_window_geometry(44, 8, 1864, 1060);
end

if (get_window_type() == "WINDOW_TYPE_DIALOG") then
    set_on_top();
    focus();
    if (not string.match(get_class_instance_name(), "gnome")) then
        debug_print("Not a Gnome dialog");
        set_window_geometry2(265-12, 90-12, 1454, 925);     -- center
    end
end

-- Design Workspace
if (get_class_instance_name()=="inkscape" or get_class_instance_name()=="krita") then
    set_window_workspace(2);
    change_workspace(2);
    -- Inkscape dialog windows are of type "NORMAL", but aren't name as "Inkscape"
    if (get_class_instance_name()~="krita" and 
        not string.match(get_window_name(), "- Inkscape")) then
        -- Move floating inkscape dialogs to right 
        set_window_geometry2(1453, 121, 361, 866);
    end
end

-- Default workspace
if (get_class_instance_name()=="Visual Studio Code" or
    get_application_name()=="DesktopEditors" or
    get_class_instance_name()=="audacity" or
    get_class_instance_name()=="kdenlive") then
    set_window_workspace(3);
    change_workspace(3);
end

-- File explorer
if (get_application_name()=="nemo") then
    set_window_workspace(4);
    change_workspace(4);
end

-- System workspace
if (get_application_name()=="cinnamon-settings.py") then
    set_window_geometry(44, 8, 1864, 1060);
    set_window_workspace(5);
    change_workspace(5);
end

-- Gaming workspace
if (get_class_instance_name()=="Steam") then
    set_window_workspace(7);
    change_workspace(7);
end

-- Media
if (get_application_name()=="Spotify" or 
    get_application_name()=="pavucontrol" or
    get_application_name()=="blueman-manager") then
    set_window_workspace(8);
    change_workspace(8);
end