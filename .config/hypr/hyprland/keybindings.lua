----------------
--- PROGRAMS ---
----------------

local terminal        = "kitty"
local fileManager     = "nautilus"
local editor          = "zed"
local browser         = "firefox"
local passwordManager = "keepassxc"


-------------------
--- KEYBINDINGS ---
-------------------

-- https://wiki.hypr.land/Configuring/Basics/Binds/
local mainMod = "SUPER"

-- Application shortcuts
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("uwsm app -- " .. terminal))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("uwsm app -- " .. terminal, {
    float = true,
    size  = { 700, 400 },
    move  = { "monitor_w * 0.6", "monitor_h * 0.1" },
}))

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm app -- " .. fileManager))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("uwsm app -- " .. editor))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("uwsm app -- " .. browser))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("uwsm app -- " .. passwordManager))

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("vicinae toggle"))

hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("vicinae vicinae://extensions/vicinae/clipboard/history"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- Change wallpaper
hl.bind(mainMod .. " + ALT + P",   hl.dsp.exec_cmd("~/.config/bin/change-wall.sh ~/Pictures/Wallpapers"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("~/.config/bin/wall-selector.sh ~/Pictures/Wallpapers"))

-- Toggle Waybar
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("killall waybar || uwsm app -- waybar -c ~/.config/waybar/config.jsonc -s ~/.config/waybar/styles.css"))

-- Toggle Microphone
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("~/.config/bin/mic-control.sh m"))

-- Screen Recording
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("~/.config/bin/record.sh"))

-- Toggle NoScreenShare
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("~/.config/bin/toggle-noscreenshare.sh"))

-- Sessions and power
-- Cycle ASUS power profile: quiet -> balanced -> performance
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("~/.config/bin/power-profile.sh"))
hl.bind(mainMod .. " + L",  hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mainMod .. " + P",  hl.dsp.exec_cmd("~/.config/bin/logout-launch.sh"))
hl.bind(mainMod .. " + ALT + D", hl.dsp.dpms({ action = "toggle" }), { locked = true })
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })

-- Screenshots
hl.bind("Print",           hl.dsp.exec_cmd("hyprshot -m output -t 1500 -o ~/Pictures/Screen -f $(date +%F_%H-%M-%S)_hyprshot.png"))
hl.bind("SHIFT + Print",   hl.dsp.exec_cmd("hyprshot -m region -t 1500 -o ~/Pictures/Screen -f $(date +%F_%H-%M-%S)_hyprshot.png"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("~/.config/bin/screenshot-satty.sh"))
hl.bind(mainMod .. " + Print",     hl.dsp.exec_cmd("~/.config/bin/screenshot-zipline.sh"))

-- Zoom (native Lua replaces the old hyprctl/awk pipeline)
local function zoom_by(delta)
    return function()
        local z = hl.get_config("cursor.zoom_factor") or 1
        hl.config({ cursor = { zoom_factor = math.max(1, z + delta) } })
    end
end
hl.bind(mainMod .. " + Z", zoom_by(0.3), { repeating = true })
hl.bind(mainMod .. " + mouse_down", zoom_by(0.5),  { dont_inhibit = true })
hl.bind(mainMod .. " + mouse_up",   zoom_by(-0.5), { dont_inhibit = true })
hl.bind(mainMod .. " + SHIFT + Z", function()
    hl.config({ cursor = { zoom_factor = 1.0 } })
end)

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + D", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.pseudo()) -- dwindle
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + S", hl.dsp.window.pin())

hl.bind(mainMod .. " + A", hl.dsp.window.fullscreen({ mode = "maximized",  action = "toggle" }))
hl.bind("F11",             hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Resize with mainMod + CONTROL + arrow keys
hl.bind(mainMod .. " + CONTROL + right", hl.dsp.window.resize({ x = 24,  y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + left",  hl.dsp.window.resize({ x = -24, y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + up",    hl.dsp.window.resize({ x = 0,   y = -24, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CONTROL + down",  hl.dsp.window.resize({ x = 0,   y = 24,  relative = true }), { repeating = true })

-- Move windows with mainMod + SHIFT + arrow keys
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,           hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,   hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + TAB",           hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(mainMod .. " + SHIFT + TAB",   hl.dsp.window.move({ workspace = "special:scratchpad" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia keys
hl.bind(mainMod .. " + F3", hl.dsp.exec_cmd("~/.config/bin/volume-control.sh d"), { repeating = true, locked = true })
hl.bind(mainMod .. " + F4", hl.dsp.exec_cmd("~/.config/bin/volume-control.sh i"), { repeating = true, locked = true })
hl.bind(mainMod .. " + F5", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { repeating = true, locked = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("~/.config/bin/volume-control.sh d"), { repeating = true, locked = true })
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("~/.config/bin/volume-control.sh i"), { repeating = true, locked = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("~/.config/bin/volume-control.sh m"), { repeating = true, locked = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("~/.config/bin/mic-control.sh m"),    { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("~/.config/bin/brightness-control.sh -o d"), { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("~/.config/bin/brightness-control.sh -o i"), { repeating = true, locked = true })

-- Clamshell Mode
-- Official switch binds (wiki: Binds → Switches). Guarded: the panel is only
-- dropped when another monitor is active — disabling the last monitor removes
-- it from the layout and dumps every window onto a fallback output.
local monitors = require("hyprland/monitors")

hl.bind("switch:on:Lid Switch", function()
    for _, m in ipairs(hl.get_monitors()) do
        if m.name ~= "eDP-1" then
            hl.monitor({ output = "eDP-1", disabled = true })
            return
        end
    end
end, { locked = true })

-- Re-apply just the eDP-1 rule instead of a full `hyprctl reload`, so the
-- external monitor and workspace layout stay untouched (no flicker/jumps).
hl.bind("switch:off:Lid Switch", function()
    hl.monitor(monitors.edp_rule)
end, { locked = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
