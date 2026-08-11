----------------
--- MONITORS ---
----------------

-- https://wiki.hypr.land/Configuring/Basics/Monitors/
--
-- Wildcard rule: every connected monitor auto-configures itself.
--   highres -> highest *resolution* (then best refresh rate at that res).
--              NOT highrr — that picks the top refresh rate even if it
--              only exists at a tiny resolution (e.g. 1024x768@75 on a
--              4K@60 panel).
hl.monitor({
    output   = "",
    mode     = "highres",
    position = "auto",
    scale    = "auto",
})

-- Built-in laptop panel: keep a fixed 1.33 scale (auto tends to misjudge it).
-- Exported so the clamshell binds in keybindings.lua can re-apply it on lid open.
local EDP_RULE = {
    output   = "eDP-1",
    mode     = "highres",
    position = "auto",
    scale    = 1.33,
    disabled = false,
}
hl.monitor(EDP_RULE)

-- Dell U3223QE 4K: 1.33 scale (auto picks 1.0, which is too small).
-- Matched by description, not port name — replugging moves it between DP-1/DP-2.
hl.monitor({
    output   = "desc:Dell Inc. DELL U3223QE F7B0N04",
    mode     = "highres",
    position = "auto",
    scale    = 1.33,
})

return { edp_rule = EDP_RULE }
