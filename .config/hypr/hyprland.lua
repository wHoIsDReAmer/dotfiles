--- HYPRLAND
-- https://wiki.hypr.land/Configuring/Start/
--
-- Lua config (hyprlang .conf is deprecated since 0.55 and will be dropped).
-- The old *.conf files are kept as a fallback: delete/rename this file and
-- Hyprland falls back to hyprland.conf on next start.
--
-- Each require() runs in its own protected scope: an error in one file
-- does not stop the others from loading.

--- GENERAL
require("hyprland/general")

--- AUTOSTART
require("hyprland/autostart")

--- MONITORS
require("hyprland/monitors")

--- KEYBINDS
require("hyprland/keybindings")

--- RULES
require("hyprland/rules")
