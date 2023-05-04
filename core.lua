local Unlocker, awful, project = ...
print("Sisterfister Monk Loaded!")
project.monk = {}
project.monk.mistweaver = awful.Actor:New({ spec = 2, class = "monk" })
