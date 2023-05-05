-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded and ready to fist!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    -- Check if there is an enemy target
    if target.enemy then
        player.face(target)
        StartAttack()
        healingElixir()
        dampenHarm()
        fortifyingBrew()
        faelineStomp()
        tigerPalm()
        blackoutKick()
        risingSunKick()
        legSweep()
        touchOfDeath()
    end
end)
