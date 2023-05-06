local Unlocker, awful, project = ...
require("gui.lua")
-- Initialize the UI
mistweaverUI:init()
awful.DevMode = true
project.monk = {}
project.monk.mistweaver = awful.Actor:New({ spec = 2, class = "monk" })
