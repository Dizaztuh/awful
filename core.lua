local Unlocker, awful, project = ...

awful.DevMode = true
require("mistweaver-ui")
project.monk = {}
project.monk.mistweaver = awful.Actor:New({ spec = 2, class = "monk" })
