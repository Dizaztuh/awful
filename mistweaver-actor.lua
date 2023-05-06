-- Import the necessary modules and get the mistweaver monk profile
local Unlocker, awful, project = ...
local mistweaver = project.monk.mistweaver

print("Sisterfister Loaded and ready to fist!")

-- Initialize the mistweaver monk profile
mistweaver:Init(function()
    -- Check if there is an enemy target
    if target.enemy then
        StartAttack()
        touchOfDeath()
        envelopingMist()
        sphereofDespair()
        faelineStomp()
        risingSunKick("prio")
        tigerPalm()
        blackoutKick()
        legSweep()
        paralyze()
        lifeCocoon()
        healingElixir()
        dampenHarm()
        sphereofHope()
        fortifyingBrew()
        diffuseMagic()
        revival()
    end
end)