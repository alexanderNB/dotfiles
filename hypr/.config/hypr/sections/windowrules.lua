hl.window_rule({ match = { class = "discord" }, workspace = "name:discord silent"})
hl.window_rule({ match = { class = "steam" }, workspace = "name:steam silent"})
-- TODO:
-- windowrule = match:class WebApp-Messenger4463, workspace name:messenger silent

hl.workspace_rule({ workspace= "name:discord", persistent = true })
hl.workspace_rule({ workspace= "name:messenger", persistent = true })
hl.workspace_rule({ workspace= "name:steam", persistent = true })
hl.workspace_rule({ workspace= "name:overview", persistent = true })
