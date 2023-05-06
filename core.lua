local Unlocker, awful, project = ...
awful.DevMode = true
project.monk = {}
project.monk.mistweaver = awful.Actor:New({ spec = 2, class = "monk" })

-- Load the 'gui.lua' module
local gui = awful.Load("gui")
gui.init()  -- Initialize the GUI
