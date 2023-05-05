local Unlocker, awful, project = ...

awful.DevMode = true

project.monk.mistweaver = {}
project.monk.mistweaver = awful.Actor:New({ spec = 2, class = "monk" })
