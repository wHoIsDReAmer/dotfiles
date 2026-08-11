#!/bin/bash
# Toggles the wildcard no_screen_share privacy rules.
# Handles both the legacy conf (rules.conf) and the Lua config (rules.lua) —
# whichever Hyprland is currently using picks up the change on reload.

CONF="$HOME/.config/hypr/hyprland/rules.conf"
LUA="$HOME/.config/hypr/hyprland/rules.lua"

CONF_LAYER_RULE="layerrule = match:namespace ^(.*)$, no_screen_share on"
CONF_WINDOW_RULE="windowrule = match:initial_class = ^(.*)$, no_screen_share on"

escape_regex() {
    printf '%s\n' "$1" | sed -e 's/[][\/.^$*]/\\&/g'
}

toggle_conf_rule() {
    local RULE_ESC
    RULE_ESC=$(escape_regex "$1")

    # uncomment if commented
    if grep -q "^# $RULE_ESC" "$CONF"; then
        sed -i "s/^# \(.*$RULE_ESC\)/\1/" "$CONF"
        echo "Enabled"

    # comment if uncommented
    elif grep -q "^$RULE_ESC" "$CONF"; then
        sed -i "s/^\($RULE_ESC\)/# \1/" "$CONF"
        echo "Disabled"
    else
        echo "None"
    fi
}

# Lua rules are single lines tagged with names starting "noscreenshare-all".
toggle_lua_rules() {
    if [[ ! -f "$LUA" ]]; then
        echo "None"
    elif grep -q '^-- hl\..*noscreenshare-all' "$LUA"; then
        sed -i 's/^-- \(hl\..*noscreenshare-all.*\)$/\1/' "$LUA"
        echo "Enabled"
    elif grep -q '^hl\..*noscreenshare-all' "$LUA"; then
        sed -i 's/^\(hl\..*noscreenshare-all.*\)$/-- \1/' "$LUA"
        echo "Disabled"
    else
        echo "None"
    fi
}

LAYER_STATE=$(toggle_conf_rule "$CONF_LAYER_RULE")
WINDOW_STATE=$(toggle_conf_rule "$CONF_WINDOW_RULE")
LUA_STATE=$(toggle_lua_rules)

notify-send "No Screenshare" "Window: $WINDOW_STATE | Layer: $LAYER_STATE | Lua: $LUA_STATE" -t 2000

sleep 0.2
hyprctl reload
