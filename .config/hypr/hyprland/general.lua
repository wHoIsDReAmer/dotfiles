---------------
--- GENERAL ---
---------------

-- https://wiki.hypr.land/Configuring/


-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "25")
hl.env("XCURSOR_THEME", "macOS-BigSur")
hl.env("HYPRCURSOR_SIZE", "25")
hl.env("HYPRCURSOR_THEME", "macos-BigSur")

hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")

hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- fcitx
hl.env("QT_IM_MODULE", "fcitx5")
hl.env("XMODIFIERS", "@im=fcitx5")


---------------------
--- LOOK AND FEEL ---
---------------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/
local colors = require("hyprland/colors")

hl.config({
    general = {
        gaps_in         = 4,
        gaps_out        = 7,
        gaps_workspaces = 20,

        border_size = 2,

        col = {
            active_border   = ("rgb(%s)"):format(colors.active_border),
            inactive_border = ("rgb(%s)"):format(colors.inactive_border),
        },

        resize_on_border  = true,
        no_focus_fallback = true,
        allow_tearing     = false,

        layout = "dwindle",

        snap = {
            enabled      = true,
            window_gap   = 20,
            monitor_gap  = 10,
            respect_gaps = true,
        },
    },

    decoration = {
        rounding = 13,

        active_opacity   = 0.92,
        inactive_opacity = 0.92,

        blur = {
            enabled           = true,
            new_optimizations = true,
            xray              = true,
            special           = false,
            size              = 13,
            passes            = 2,
            brightness        = 1,
            noise             = 0.04,
            contrast          = 0.9,
        },

        shadow = {
            enabled = false,
        },
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper   = 0,
        disable_hyprland_logo     = true,
        animate_manual_resizes    = false,
        on_focus_under_fullscreen = 2,
        allow_session_lock_restore = true,
        focus_on_activate         = true,
    },

    binds = {
        hide_special_on_workspace_change = true,
        drag_threshold                   = 10,
    },

    cursor = {
        zoom_factor     = 1,
        zoom_rigid      = false,
        hotspot_padding = 1,
        zoom_disable_aa = false,
    },

    ecosystem = {
        no_update_news = true,
    },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("wind",     { type = "bezier", points = { {0.05, 0.9},  {0.1, 1.05}  } })
hl.curve("overshot", { type = "bezier", points = { {0.18, 0.95}, {0.22, 1.03} } })
hl.curve("liner",    { type = "bezier", points = { {1, 1},       {1, 1}       } })

hl.animation({ leaf = "windows",     enabled = true, speed = 6, bezier = "wind",     style = "slide" })
hl.animation({ leaf = "windowsIn",   enabled = true, speed = 6, bezier = "overshot", style = "popin 60%" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 6, bezier = "overshot", style = "popin 60%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "wind",     style = "slide" })

hl.animation({ leaf = "workspaces",  enabled = true, speed = 5, bezier = "wind" })

hl.animation({ leaf = "fade",        enabled = true, speed = 4, bezier = "default" })
-- hl.animation({ leaf = "border",      enabled = true, speed = 1,  bezier = "liner" })
-- hl.animation({ leaf = "borderangle", enabled = true, speed = 20, bezier = "liner", style = "loop" })


-------------
--- INPUT ---
-------------

-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config({
    input = {
        kb_layout  = "us,kr",
        kb_variant = "",
        kb_model   = "",
        -- kb_options = "grp:win_space_toggle,grp:caps_toggle,grp_led:caps",
        kb_options = "ctrl:swapcaps,korean:ralt_hangul",
        kb_rules   = "",

        numlock_by_default = true,
        follow_mouse       = 1,

        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
            scroll_factor  = 0.8,
        },
    },
})


----------------
--- GESTURES ---
----------------

-- https://wiki.hypr.land/Configuring/Gestures/
hl.config({
    gestures = {
        workspace_swipe_distance                 = 600,
        workspace_swipe_cancel_ratio             = 0.2,
        workspace_swipe_min_speed_to_force       = 5,
        workspace_swipe_direction_lock           = true,
        workspace_swipe_direction_lock_threshold = 10,
        workspace_swipe_create_new               = true,
    },
})

hl.gesture({ fingers = 3, direction = "swipe",      action = "move" })
hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 4, direction = "up",   scale = 1.5, action = "fullscreen" })
hl.gesture({ fingers = 4, direction = "down", scale = 1.5, action = "fullscreen", mode = "maximize" })
