local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweavr

local Spell = awful.Spell

awful.Populate({
    tigerPalm = Spell(100780, { damage = "physical" }),

}, mistweaver, getfenv(1))