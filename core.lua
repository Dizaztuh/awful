local Unlocker, awful, project = ...
local mistweaverUI = require("gui")
local gui = require("gui")(Unlocker)
awful.DevMode = true
project.monk = {}
project.monk.mistweaver = awful.Actor:New({ spec = 2, class = "monk" })
