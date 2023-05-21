local Unlocker, awful, project = ...
local mistweaver = project.priest.discipline

print("Dizazter's Discipline Priest Loaded")

discipline:Init(function()
    if not player.mounted and target.enemy then
    renew()
    PwShield()
    purgeTheWicked()
    penance()
    schism()
    end
end)