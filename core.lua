local Unlocker, awful, project = ...
print("project Monk rotation loaded and ready!")
project.monk = {}
project.monk.mistweaver = awful.Actor:New({ spec = 2, class = "monk" })