local Unlocker, awful, project = ...
local mistweaverUI = require("gui")
-- Initialize the UI
mistweaverUI:init()
awful.DevMode = true
project.monk = {}
project.monk.mistweaver = awful.Actor:New({ spec = 2, class = "monk" })
