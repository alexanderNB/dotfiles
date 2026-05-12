hl.config({
    xwayland = {
        force_zero_scaling = false
    },
})

if System == "PC" then
    hl.monitor({
        output = "DP-1",
        mode = "highres",
        position = "0x3000",
        scale = "1",
    })

    hl.monitor({
        output = "DP-2",
        mode = "highres",
        position = "2560x0",
        scale = "1",
    })


    hl.workspace_rule({ workspace = "1",  monitor = "DP-1", default = true  })
    hl.workspace_rule({ workspace = "2",  monitor = "DP-1", default = false })
    hl.workspace_rule({ workspace = "3",  monitor = "DP-1", default = false })
    hl.workspace_rule({ workspace = "4",  monitor = "DP-1", default = false })
    hl.workspace_rule({ workspace = "5",  monitor = "DP-1", default = false })
    hl.workspace_rule({ workspace = "6",  monitor = "DP-1", default = false })
    hl.workspace_rule({ workspace = "7",  monitor = "DP-1", default = false })
    hl.workspace_rule({ workspace = "8",  monitor = "DP-1", default = false })
    hl.workspace_rule({ workspace = "9",  monitor = "DP-1", default = false })
    hl.workspace_rule({ workspace = "10", monitor = "DP-1", default = false })

    hl.workspace_rule({ workspace = "11", monitor = "DP-2", default = true  })
    hl.workspace_rule({ workspace = "12", monitor = "DP-2", default = false })
    hl.workspace_rule({ workspace = "13", monitor = "DP-2", default = false })
    hl.workspace_rule({ workspace = "14", monitor = "DP-2", default = false })
    hl.workspace_rule({ workspace = "15", monitor = "DP-2", default = false })
    hl.workspace_rule({ workspace = "16", monitor = "DP-2", default = false })
    hl.workspace_rule({ workspace = "17", monitor = "DP-2", default = false })
    hl.workspace_rule({ workspace = "18", monitor = "DP-2", default = false })
    hl.workspace_rule({ workspace = "19", monitor = "DP-2", default = false })
    hl.workspace_rule({ workspace = "20", monitor = "DP-2", default = false })

    hl.config({
        render = {
            cm_sdr_eotf = "0",
        }
    })
else
    hl.monitor({
        output = "eDP-1",
        mode = "highres",
        position = "auto",
        scale = "1"
    })

    hl.config({
        render = {
            cm_sdr_eotf = 2
        }
    })

end
