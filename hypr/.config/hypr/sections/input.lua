hl.config({
    input = {
        kb_layout  = "dk",
        kb_variant = "nodeadkeys",
        kb_model   = "",
        kb_options = "caps:escape",
        kb_rules   = "",


        follow_mouse = 1,
        repeat_rate = 60,
        repeat_delay = 300,
        sensitivity = 0.5, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
            scroll_factor = 1
        },
    },

    binds = {
        hide_special_on_workspace_change = true
    },

    cursor = {
        inactive_timeout = 2
    }
})
